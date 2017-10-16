<?php

namespace Spisovka;

use Nette;

class Admin_SpisznakPresenter extends BasePresenter
{

    private $spisznak;

    public function renderSeznam()
    {
        $this->template->title = " - Seznam spisových znaků";

        $client_config = GlobalVariables::get('client_config');
        $vp = new Components\VisualPaginator($this, 'vp', $this->getHttpRequest());
        $paginator = $vp->getPaginator();
        $paginator->itemsPerPage = isset($client_config->nastaveni->pocet_polozek) ? $client_config->nastaveni->pocet_polozek
                    : 20;

        $where = null; // array( array('ciselna_rada LIKE %s','ORG_12%') );

        $SpisovyZnak = new SpisovyZnak();
        $result = $SpisovyZnak->seznam($where);
        $paginator->itemCount = count($result);
        $seznam = $result->fetchAll($paginator->offset, $paginator->itemsPerPage);
        $this->template->seznam = $seznam;
    }

    public function renderNovy()
    {
        $this->template->title = " - Nový spisový znak";
    }

    public function renderDetail($id)
    {
        $this->template->FormUpravit = $this->getParameter('upravit', null);

        $SpisovyZnak = new SpisovyZnak();
        $this->spisznak = $SpisovyZnak->getInfo($id);
        $this->template->SpisZnak = $this->spisznak;

        $this->template->has_children = $SpisovyZnak->ma_podrizene_spisove_znaky($id);

        $this->template->title = " - Detail spisového znaku";
    }

    protected function _odebrat($odebrat_strom)
    {
        $spisznak_id = $this->getParameter('id');
        $SpisovyZnak = new SpisovyZnak();
        $res = $SpisovyZnak->odstranit($spisznak_id, $odebrat_strom);
        if (!$res) {
            $this->flashMessage("Spisový znak je využíván v aplikaci.\nZ toho důvodu není možné spisový znak odstranit.",
                    'warning');
            $this->redirect('detail', $spisznak_id);
        } else {
            $this->flashMessage('Spisový znak byl úspěšně odstraněn.');
            $this->redirect('seznam');
        }
    }

    public function actionOdebrat()
    {
        $this->_odebrat(false);
    }

    public function actionOdebratstrom()
    {
        $this->_odebrat(true);
    }

    public function renderExport()
    {
        if ($this->getHttpRequest()->isMethod('POST')) {
            // Exportovani
            $post_data = $this->getHttpRequest()->getPost();
            //Nette\Diagnostics\Debugger::dump($post_data);

            $SpisovyZnak = new SpisovyZnak();
            $args = null;
            if ($post_data['export_co'] == 2) {
                // pouze aktivni
                $args['where'] = array(array('stav=1'));
            }

            $seznam = $SpisovyZnak->seznam($args)->fetchAll();

            if ($seznam) {

                if ($post_data['export_do'] == "csv") {
                    // export do CSV
                    $ignore_cols = array("date_created", "user_created", "date_modified", "user_modified",
                        "sekvence_string");
                    $export_data = CsvExport::csv(
                                    $seznam, $ignore_cols, $post_data['csv_code'],
                                    $post_data['csv_radek'], $post_data['csv_sloupce'],
                                    $post_data['csv_hodnoty']);

                    //echo "<pre>"; echo $export_data; echo "</pre>"; exit;

                    $httpResponse = $this->getHttpResponse();
                    $httpResponse->setContentType('application/octetstream');
                    $httpResponse->setHeader('Content-Description', 'File Transfer');
                    $httpResponse->setHeader('Content-Disposition',
                            'attachment; filename="export_subjektu.csv"');
                    $httpResponse->setHeader('Content-Transfer-Encoding', 'binary');
                    $httpResponse->setHeader('Expires', '0');
                    $httpResponse->setHeader('Cache-Control',
                            'must-revalidate, post-check=0, pre-check=0');
                    $httpResponse->setHeader('Pragma', 'public');
                    $httpResponse->setHeader('Content-Length', strlen($export_data));
                    echo $export_data;
                    exit;
                }
            } else {
                $this->flashMessage('Nebyly nalezany žádné data k exportu!', 'warning');
            }
        }
    }

    /**
     *
     * Formular a zpracovani pro zmenu spisoveho znaku
     *
     */
    protected function createComponentUpravitForm()
    {

        $SpisovyZnak = new SpisovyZnak();
        if (empty($this->spisznak)) {
            $id = $this->getParameter('id', null);
            if ($id !== null)
                $spisznak = $SpisovyZnak->getInfo($id);
            else
                $spisznak = array();
        } else {
            $spisznak = $this->spisznak;
        }
        $spisznak_seznam = $SpisovyZnak->selectBox(1, ['exclude_id' => @$spisznak->id]);
        $stav_select = SpisovyZnak::stav();
        $spousteci = SpisovyZnak::spousteci_udalost(null, 1);
        $skar_znak = array('A' => 'A', 'S' => 'S', 'V' => 'V');


        $form1 = new Form();
        $form1->addHidden('id')
                ->setValue(@$spisznak->id);

        $form1->addText('nazev', 'Spisový znak:', 50, 80)
                ->setValue(@$spisznak->nazev)
                ->addRule(Nette\Forms\Form::FILLED, 'Spisový znak musí být vyplněn!');
        $form1->addText('popis', 'Popis:', 50, 200)
                ->setValue(@$spisznak->popis);
        $form1->addSelect('skartacni_znak', 'Skartační znak:', $skar_znak)
                ->setValue(@$spisznak->skartacni_znak);
        $form1->addText('skartacni_lhuta', 'Skartační lhůta:', 5, 5)
                ->setValue(@$spisznak->skartacni_lhuta);
        $form1->addSelect('spousteci_udalost_id', 'Spouštěcí událost:', $spousteci)
                ->setValue(@$spisznak->spousteci_udalost_id);

        $form1->addSelect('parent_id', 'Připojit k:', $spisznak_seznam)
                ->setValue(@$spisznak->parent_id);
        $form1->addSelect('stav', 'Změnit stav na:', $stav_select)
                ->setValue(@$spisznak->stav);

        $submit = $form1->addSubmit('upravit', 'Upravit');
        $submit->onClick[] = array($this, 'upravitClicked');

        $form1->addSubmit('storno', 'Zrušit')
                        ->setValidationScope(FALSE)
                ->onClick[] = array($this, 'stornoClicked');

        return $form1;
    }

    public function upravitClicked(Nette\Forms\Controls\SubmitButton $button)
    {
        $data = $button->getForm()->getValues();

        $spisznak_id = $data['id'];
        unset($data['id']);

        $SpisovyZnak = new SpisovyZnak();

        try {
            $SpisovyZnak->upravit($data, $spisznak_id);
            $this->flashMessage('Spisový znak  "' . $data['nazev'] . '"  byl upraven.');
        } catch (\Exception $e) {
            $this->flashMessage('Spisový znak "' . $data['nazev'] . '" se nepodařilo upravit.',
                    'warning');
            $this->flashMessage($e->getMessage(), 'warning');
        }

        $this->redirect('detail', array('id' => $spisznak_id));
    }

    public function stornoClicked(Nette\Forms\Controls\SubmitButton $button)
    {
        $data = $button->getForm()->getValues();
        $this->redirect('this', array('id' => $data['id']));
    }

    public function stornoNovyClicked()
    {
        $this->redirect('seznam');
    }

    protected function createComponentNovyForm()
    {
        $SpisovyZnak = new SpisovyZnak();
        $spisznak_seznam = $SpisovyZnak->selectBox(1);
        $spousteci = SpisovyZnak::spousteci_udalost(null, 1);
        $skar_znak = array('A' => 'A', 'S' => 'S', 'V' => 'V');

        $form = new Form();
        $form->addText('nazev', 'Spisový znak:', 50, 80)
                ->addRule(Nette\Forms\Form::FILLED, 'Spisový znak musí být vyplněn!');
        $form->addText('popis', 'Popis:', 50, 200);
        $form->addSelect('skartacni_znak', 'Skartační znak:', $skar_znak);
        $form->addText('skartacni_lhuta', 'Skartační lhůta:', 5, 5);
        $form->addSelect('spousteci_udalost_id', 'Spouštěcí událost:', $spousteci);
        $default_event = StartEvent::getDefault();
        if ($default_event)
            $form['spousteci_udalost_id']->setDefaultValue($default_event->id);

        $form->addSelect('parent_id', 'Připojit k:', $spisznak_seznam);
        $form->addSelect('stav', 'Stav:', SpisovyZnak::stav())
                ->setDefaultValue(1);

        $form->addSubmit('vytvorit', 'Vytvořit');
        $form->addSubmit('vytvorit_a_novy', 'Vytvořit a vložit další');
        $form->addSubmit('storno', 'Zrušit')
                        ->setValidationScope(FALSE)
                ->onClick[] = array($this, 'stornoNovyClicked');

        $form->onSuccess[] = array($this, 'vytvoritSucceeded');

        return $form;
    }

    public function vytvoritSucceeded(Nette\Application\UI\Form $form, $data)
    {
        $SpisovyZnak = new SpisovyZnak();

        try {
            $spisznak_id = $SpisovyZnak->vytvorit($data);
            $this->flashMessage('Spisový znak  "' . $data['nazev'] . '" byl vytvořen.');
            $submit = $form->isSubmitted();
            if ($submit->name == 'vytvorit_a_novy')
                $this->redirect('novy');
            else
                $this->redirect('detail', ['id' => $spisznak_id]);
        } catch (DibiException $e) {
            $this->flashMessage('Spisový znak "' . $data['nazev'] . '" se nepodařilo vytvořit.',
                    'warning');
            $this->flashMessage($e->getMessage(), 'warning');
        }
    }

    public function actionRebuild()
    {
        $m = new SpisovyZnak();
        $m->rebuildIndex();
        $this->flashMessage('Operace proběhla úspěšně.');
        $this->redirect('seznam');
    }

}

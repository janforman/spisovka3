<?php

namespace Spisovka;

use Nette;

class Spisovka_VypravnaPresenter extends BasePresenter
{

    private $typ_evidence = null;
    private $seradit = null;

    public function startup()
    {
        $client_config = GlobalVariables::get('client_config');
        $this->typ_evidence = $client_config->cislo_jednaci->typ_evidence;
        $this->template->Oddelovac_poradi = $client_config->cislo_jednaci->oddelovac;

        parent::startup();
    }

    public function renderDefault($hledat)
    {
        $this->template->Typ_evidence = $this->typ_evidence;

        $Dokument = new DokumentOdeslani();
        $seznam = array();

        $seradit = UserSettings::get('vypravna_seradit', 'datum');
        // Uloz hodnotu pro pouziti ve formulari razeni
        $this->seradit = $seradit;

        $filtr = UserSettings::get('vypravna_filtr');
        $this->template->zobraz_zrusit_filtr = !empty($filtr);

        // Volba vystupu - web/tisk/pdf
        if ($this->getParameter('print') || $this->getParameter('print_balik')) {
            if ($vyber = $this->getParameter('vyber')) {
                $seznam = $Dokument->kOdeslani($seradit, explode('-', $vyber));
            } else {
                $filtr_tisk = $this->getParameter('print_balik') ? "balik" : "doporucene";
                $seznam = $Dokument->kOdeslani($seradit, $hledat, $filtr_tisk);
            }
            $this->pdf_output = true;
            $this->template->count_page = ceil(count($seznam) / 10);
            $this->template->cislo_zakaznicke_karty = Settings::get('Ceska_posta_cislo_zakaznicke_karty',
                            '');
            $this->template->zpusob_uhrady = Settings::get('Ceska_posta_zpusob_uhrady', '');

            $ciselnik = Admin_NastaveniPresenter::$ciselnik_zpusoby_uhrad;
            array_shift($ciselnik);
            $this->template->zpusoby_uhrad = $ciselnik;

            $this->setView('podaciarch');
        } else {
            $seznam = $Dokument->kOdeslani($seradit, $hledat, $filtr);
        }

        $this->template->seznam = $seznam;
    }

    protected function pdfExport($content)
    {
        $content = str_replace("<td", "<td valign='top'", $content);

        // Poznamka: zde dany font se nepouzije, pouzije se font z CSS
        // Dulezite zde jde presne nastaveni okraju formulare
        $mpdf = new \mPDF('iso-8859-2', 'A4', 9, 'Helvetica', 7, 9, 8, 6, 0, 0);

        $app_info = new VersionInformation();
        $mpdf->SetCreator($app_info->name);
        $mpdf->SetAuthor($this->user->displayName);
        $mpdf->SetTitle('Podací arch');
        
        $mpdf->WriteHTML($content);
        $mpdf->Output('podaci_arch.pdf', 'I');
    }

    public function createComponentBulkAction()
    {
        $BA = new Components\BulkAction();

        $actions = ['odeslat' => 'odesláno',
            'vratit' => 'vrátit',
            'podaci_arch' => 'vytisknout podací arch'
        ];
        $BA->setActions($actions);
        $BA->setCallback([$this, 'bulkAction']);
        $BA->text_object = 'záznam';

        return $BA;
    }

    public function bulkAction($action, $items)
    {
        $DokumentOdeslani = new DokumentOdeslani();
        switch ($action) {
            case 'odeslat':
                $count_ok = $count_failed = 0;
                foreach ($items as $dokument_odeslani_id)
                    if ($DokumentOdeslani->odeslano($dokument_odeslani_id))
                        $count_ok++;
                    else
                        $count_failed++;

                if ($count_ok > 0) {
                    switch ($count_ok) {
                        case 1: $msg = "Záznam byl označen jako odeslaný.";
                            break;
                        case 2:
                        case 3:
                        case 4: $msg = "$count_ok záznamy byly označeny jako odeslané.";
                            break;
                        default:
                            $msg = "$count_ok záznamů bylo označeno jako odeslané.";
                    }
                    $this->flashMessage($msg);
                }
                if ($count_failed > 0)
                // K tomuto nikdy nedojde, jelikož při chybě je hozena výjimka
                    $this->flashMessage("$count_failed záznamů se nepodařilo označit jako odeslané!",
                            'warning');
                break;

            case 'vratit':
                $count_ok = $count_failed = 0;
                foreach ($items as $dokument_odeslani_id)
                    if ($DokumentOdeslani->vraceno($dokument_odeslani_id))
                        $count_ok++;
                    else
                        $count_failed++;

                if ($count_ok > 0)
                    $this->flashMessage('Úspěšně jste vrátil ' . $count_ok . ' dokumentů.');
                if ($count_failed > 0)
                    $this->flashMessage('' . $count_failed . ' dokumentů se nepodařilo vrátit!',
                            'warning');
                break;

            case 'podaci_arch':
                $vyber = $items;
                $this->redirect('this', ['print' => 1, 'vyber' => implode('-', $vyber)]);
                break;

            default:
                break;
        }
    }

    public function renderZobrazFax($id)
    {
        $DokumentOdeslani = new DokumentOdeslani();
        $dokument = $DokumentOdeslani->get($id);
        if (!$dokument)
            throw new \Exception("Záznam o odeslání ID $id neexistuje.");

        $this->template->dokument = $dokument;
        $this->template->isPrint = $this->getParameter('print');
    }

    public function renderDetail($id)
    {
        $DokumentOdeslani = new DokumentOdeslani();
        $odes = $DokumentOdeslani->get($id);
        if (!$odes)
            throw new \Exception("Záznam o odeslání ID $id neexistuje.");

        $this->template->dokument = $odes;
    }

    protected function createComponentSeraditForm()
    {
        $select = array(
            'datum' => 'data odeslání (vzestupně)',
            'datum_desc' => 'data odeslání (sestupně)',
            'cj' => 'čísla jednacího (vzestupně)',
            'cj_desc' => 'čísla jednacího (sestupně)'
        );

        $form = new Nette\Application\UI\Form();
        $form->addSelect('seradit', 'Seřadit podle:', $select)
                ->setValue($this->seradit)
                ->getControlPrototype()->onchange("return document.forms['frm-seraditForm'].submit();");

        $form->onSuccess[] = array($this, 'seraditSucceeded');

        $renderer = $form->getRenderer();
        $renderer->wrappers['controls']['container'] = null;
        $renderer->wrappers['pair']['container'] = null;
        $renderer->wrappers['label']['container'] = null;
        $renderer->wrappers['control']['container'] = null;

        return $form;
    }

    public function seraditSucceeded(Nette\Application\UI\Form $form, $form_data)
    {
        UserSettings::set('vypravna_seradit', $form_data['seradit']);
        $this->redirect('this');
    }

    public function actionReset()
    {
        $what = $this->getParameter('reset');
        if ($what == 'filtr')
            UserSettings::remove('vypravna_filtr');
        $this->redirect('default');
    }

    protected function createComponentFiltrovatForm()
    {
        $form = new Form();

        $filtr = UserSettings::get('vypravna_filtr');
        $form->addComponent(new Controls\VyberPostovniZasilkyControl(), 'druh_zasilky');
        $form['druh_zasilky']->setDefaultValue($filtr);

        $form->addSubmit('filtrovat', 'Filtrovat')
                ->onClick[] = array($this, 'filtrovatClicked');
        $form->addSubmit('storno', 'Zrušit')
                        ->setValidationScope(false)
                ->controlPrototype->onclick = 'return closeDialog();';

        return $form;
    }

    public function filtrovatClicked(Nette\Forms\Controls\SubmitButton $button)
    {
        $data = $button->getForm()->getValues();
        if (!empty($data->druh_zasilky)) {
            // nastav filtrovani               
            UserSettings::set('vypravna_filtr', $data->druh_zasilky);
        } else {
            // zrus filtrovani
            UserSettings::remove('vypravna_filtr');
        }

        // v obou pripadech prejdi na vychozi stranku vypravny
        $this->redirect('default');
    }

    protected function createComponentOdeslaniForm()
    {
        $DokumentOdeslani = new DokumentOdeslani();
        $odes = $DokumentOdeslani->get($this->getParameter('id'));

        $form = new Form();

        $form->addDatePicker('datum_odeslani', 'Datum odeslání:')
                ->setRequired()
                ->setDefaultValue($odes->datum_odeslani);

        if ($odes->zpusob_odeslani_id == 3) {
            $form->addComponent(new Controls\VyberPostovniZasilkyControl(),
                    'druh_zasilky');
            $form['druh_zasilky']->setDefaultValue($odes->druh_zasilky)
                    ->setRequired();
            // $test = [5 => 'prvni polozka', 3=>'druha', 2=>'treti'];
            // $form->addComponent(new Nette\Forms\Controls\CheckboxList('Druh zásilky:', $test), 'druhZasilky');

            $form->addFloat('cena', 'Cena:', 10)
                    ->setDefaultValue($odes->cena)
                    ->setOption('description', 'Kč');
            $form->addFloat('hmotnost', 'Hmotnost:', 10)
                    ->setDefaultValue($odes->hmotnost)
                    ->setOption('description', 'kg');
            $form->addText('poznamka', 'Poznámka:')
                    ->setDefaultValue($odes->poznamka);
        } else if ($odes->zpusob_odeslani_id == 4) {
            $form->addText('cislo_faxu', 'Číslo faxu:', 20)
                    ->setDefaultValue($odes->cislo_faxu);
            $form->addTextArea('zprava', 'Zpráva pro příjemce:', 80, 5)
                    ->setDefaultValue($odes->zprava);
        }

        $form->addSubmit('vypravna_upravit', 'Uložit')
                ->onClick[] = array($this, 'ulozitClicked');
        $form->addSubmit('vypravna_storno', 'Zrušit')
                        ->setValidationScope(false)
                ->onClick[] = array($this, 'stornoClicked');

        return $form;
    }

    public function stornoClicked()
    {
        $this->redirect('default');
    }

    public function ulozitClicked(Nette\Forms\Controls\SubmitButton $button)
    {
        $data = $button->getForm()->getValues();
        $id = $this->getParameter('id');

        $data->druh_zasilky = implode(',', $data->druh_zasilky);

        $DokumentOdeslani = new DokumentOdeslani();
        $DokumentOdeslani->update($data, [["id=%i", $id]]);

        $this->flashMessage('Záznam byl úspěšně upraven.');
        $this->redirect('default');
    }

}

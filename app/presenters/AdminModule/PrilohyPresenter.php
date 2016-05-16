<?php

class Admin_PrilohyPresenter extends BasePresenter
{

    public function renderDefault()
    {
        $client_config = GlobalVariables::get('client_config');
        $vp = new VisualPaginator($this, 'vp', $this->getHttpRequest());
        $paginator = $vp->getPaginator();
        $paginator->itemsPerPage = isset($client_config->nastaveni->pocet_polozek) ? $client_config->nastaveni->pocet_polozek
                    : 20;

        $FileModel = new FileModel();
        $result = $FileModel->seznam();
        $paginator->itemCount = count($result);

        $seznam = $FileModel->fetchPart($result, $paginator->offset, $paginator->itemsPerPage);
        $this->template->seznam = $seznam;
    }

    public function actionDownload($id)
    {
        $res = $this->storage->download($id);

        if ($res == 0) {
            $this->terminate();
        } else if ($res == 1) {
            // not found
            $this->flashMessage('Požadovaný soubor nenalezen!', 'warning');
            $this->redirect(':Admin:Prilohy:default');
        } else if ($res == 2) {
            $this->flashMessage('Chyba při stahování!', 'warning');
            $this->redirect(':Admin:Prilohy:default');
        } else if ($res == 3) {
            $this->flashMessage('Neoprávněný přístup! Nemáte povolení stáhnut zmíněný soubor!', 'warning');
            $this->redirect(':Admin:Prilohy:default');
        }
    }


}

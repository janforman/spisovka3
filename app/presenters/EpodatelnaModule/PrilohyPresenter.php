<?php

namespace Spisovka;

use Nette;

class Epodatelna_PrilohyPresenter extends BasePresenter
{

    public function actionDownload($id, $file)
    {
        $file_id = $file;
        $msg = EpodatelnaMessage::factory($id);

        if ($msg instanceof EmailMessage) {
            $path = $msg->getEmailFile($this->storage);
            $soubor = EpodatelnaPrilohy::getEmailPart($path, $file_id);
        } elseif ($msg instanceof IsdsMessage) {
            $path = $msg->getIsdsFile($this->storage);
            $soubor = EpodatelnaPrilohy::getIsdsFile($path, $file_id);
        }

        if ($soubor) {
            $data = $soubor['data'];
            $httpResponse = $this->getHttpResponse();
            $mime_type = isset($soubor->mime_type) ? $soubor->mime_type : $this->_getMimeType($data);
            if ($mime_type)
                $httpResponse->setContentType($mime_type);
            $httpResponse->setHeader('Content-Length', strlen($data));
            $httpResponse->setHeader('Content-Description', 'File Transfer');
            $httpResponse->setHeader('Content-Disposition',
                    'attachment; filename="' . $soubor['file_name'] . '"');
            $httpResponse->setHeader('Content-Transfer-Encoding', 'binary');
            $httpResponse->setHeader('Expires', '0');
            $httpResponse->setHeader('Cache-Control',
                    'must-revalidate, post-check=0, pre-check=0');
            $httpResponse->setHeader('Pragma', 'public');

            echo $data;
            $this->terminate();
        }
    }

    protected function _getMimeType($data)
    {
        if (function_exists('finfo_open')) {
            $finfo = finfo_open(FILEINFO_MIME_TYPE);
            $mimetype = finfo_buffer($finfo, $data);
            finfo_close($finfo);
            return $mimetype;
        }

        return null;
    }

    public function renderAttachments($id)
    {
        $model = new EpodatelnaPrilohy();
        $attachments = $model->getFileList(EpodatelnaMessage::factory($id), $this->storage);
        $this->sendJson($attachments);
    }
}

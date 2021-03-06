<?php

namespace Spisovka;

class Subjekt extends BaseModel
{

    protected $name = 'subjekt';

    public function hledat($data, $typ, $only_name = false)
    {
        if (is_array($data))
            $data = \Nette\Utils\ArrayHash::from($data);
        $result = array();
        $cols = array('id');

        if ($typ == 'email') {
            // hledani podle emailu
            if (!empty($data->email)) {
                $sql = array(
                    'cols' => $cols,
                    /* 'order'=> array('nazev_subjektu','prijmeni','jmeno') */
                    /* P.L. nechapu, proc se zde zabyvat komplikovanym razenim. Subjekt s danou e-mailovou adresou bude obvykle jeden, ne? */
                    'order_sql' => 'CONCAT(nazev_subjektu,prijmeni,jmeno)',
                    'where' => [['email = %s', $data->email]]
                );

                $fetch = $this->selectComplex($sql)->fetchPairs('id', 'id');
                $result = array_merge($result, $fetch);
            }

            // hledani podle nazvu, prijmeni nebo jmena
            if (!empty($data->nazev_subjektu)) {
                $sql = array(
                    'cols' => $cols,
                    'where_or' => array(
                        array('nazev_subjektu LIKE %s', "%$data->nazev_subjektu%"),
                        array("CONCAT(prijmeni,' ',jmeno) = %s", $data->nazev_subjektu),
                        array("CONCAT(jmeno,' ',prijmeni) = %s", $data->nazev_subjektu)
                    ),
                    'order' => array('nazev_subjektu', 'prijmeni', 'jmeno')
                );
                $fetch = $this->selectComplex($sql)->fetchPairs('id', 'id');
                $result = array_merge($result, $fetch);
            }
        } else if ($typ == 'isds') {

            // hledani podle ISDS ID
            if (!empty($data->id_isds)) {
                $sql = array(
                    'cols' => $cols,
                    'where' => array(array('id_isds LIKE %s', '%' . $data->id_isds . '%')),
                    'order' => array('nazev_subjektu', 'prijmeni', 'jmeno')
                );
                $result = $this->selectComplex($sql)->fetchPairs('id', 'id');
            }

            // hledani podle nazvu, prijmeni nebo jmena
            // 2016-05-17  Oprava - pokud jsme nalezli subjekt podle datové schránky,
            // nevypisuj spoustu falešných výsledků, mohou jich být desítky
            if (!$result && !empty($data->nazev_subjektu)) {
                $sql = array(
                    'cols' => $cols,
                    'where_or' => array(
                        array('nazev_subjektu LIKE %s', '%' . $data->nazev_subjektu . '%'),
                        array("CONCAT(prijmeni,' ',jmeno) LIKE %s", '%' . $data->nazev_subjektu . '%'),
                        array("CONCAT(jmeno,' ',prijmeni) LIKE %s", '%' . $data->nazev_subjektu . '%')
                    ),
                    'order' => array('nazev_subjektu', 'prijmeni', 'jmeno')
                );
                $result = $this->selectComplex($sql)->fetchPairs('id', 'id');
            }
        }

        $ids = array_unique($result);
        if (!count($ids))
            return null;

        $subjekty = $this->select([['id IN %in', $ids]])->fetchAll();
        foreach ($subjekty as $subjekt) {
            $subjekt->full_name = self::displayName($subjekt, 'full');
        }

        if (!$only_name)
            return $subjekty;

        $res = [];
        foreach ($subjekty as $subjekt)
            $res[] = ['id' => $subjekt->id, 'full_name' => $subjekt->full_name];

        return $res;
    }

    public function seznam($args = null)
    {
        $params = array();

        if (isset($args['where'])) {
            $params['where'] = $args['where'];
        }

        if (isset($args['order'])) {
            $params['order'] = $args['order'];
        } else {
            $params['order_sql'] = "CONCAT(nazev_subjektu,prijmeni,jmeno)";
        }

        if (isset($args['offset'])) {
            $params['offset'] = $args['offset'];
        }

        if (isset($args['limit'])) {
            $params['limit'] = $args['limit'];
        }

        $res = $this->selectComplex($params);
        return ($res) ? $res : NULL;
    }

    public static function displayName($data, $display = 'jmeno')
    {
        if (is_string($data))
            return $data;
        if (is_array($data))
            $data = new ArrayObject($data, ArrayObject::ARRAY_AS_PROPS);
        if (!is_object($data))
            return "";

        // Sestaveni casti

        $titul_pred = "";
        $titul_pred_item = "";
        if (isset($data->titul_pred)) {
            if (!empty($data->titul_pred)) {
                $titul_pred = $data->titul_pred . " ";
                $titul_pred_item = ", " . $data->titul_pred;
            }
        }

        $jmeno = "";
        if (isset($data->jmeno)) {
            if (!empty($data->jmeno)) {
                $jmeno = $data->jmeno;
            }
        }

        $prostredni_jmeno = "";
        $prostredni_jmeno_item = "";
        if (isset($data->prostredni_jmeno)) {
            if (!empty($data->prostredni_jmeno)) {
                $prostredni_jmeno = $data->prostredni_jmeno . " ";
                $prostredni_jmeno_item = " " . $data->prostredni_jmeno;
            }
        }

        $prijmeni = "";
        if (isset($data->prijmeni)) {
            if (!empty($data->prijmeni)) {
                $prijmeni = $data->prijmeni;
            }
        }

        $titul_za = "";
        if (isset($data->titul_za)) {
            if (!empty($data->titul_za)) {
                $titul_za = ', ' . $data->titul_za;
            }
        }

        $nazev = trim($data->nazev_subjektu);
        $nazev_item = trim($data->nazev_subjektu);
        $osoba = trim($titul_pred . $jmeno . " " . $prostredni_jmeno . $prijmeni . $titul_za);
        $osoba_item = trim($prijmeni . " " . $jmeno . $prostredni_jmeno_item . $titul_pred_item . $titul_za);

        if (!empty($nazev) && !empty($osoba)) {
            $d_nazev = $nazev . ", " . $osoba;
            $d_nazev_item = $nazev_item . ", " . $osoba_item;
            $d_osoba = $osoba;
            $d_osoba_item = $osoba_item;
        } else if (!empty($nazev) && empty($osoba)) {
            $d_nazev = $nazev;
            $d_nazev_item = $nazev_item;
            $d_osoba = "";
            $d_osoba_item = "";
        } else if (empty($nazev) && !empty($osoba)) {
            $d_nazev = $osoba;
            $d_nazev_item = $osoba_item;
            $d_osoba = $osoba;
            $d_osoba_item = $osoba_item;
        } else {
            $d_nazev = "";
            $d_nazev_item = "";
            $d_osoba = "";
            $d_osoba_item = "";
        }

        //if ( strpos(@$data->type,'OVM')!==false || strpos(@$data->type,'PO')!==false ) {
        // nazev subjektu
        //    $d_nazev = $nazev;
        //    $d_nazev_item = $nazev;
        //}
        // sestaveni adresy
        if (!empty($data->adresa_co) && !empty($data->adresa_cp) && !empty($data->adresa_ulice)) {
            $d_ulice = @$data->adresa_ulice . ' ' . @$data->adresa_cp . '/' . @$data->adresa_co;
        } else if (empty($data->adresa_ulice) && !empty($data->adresa_cp)) {
            $d_ulice = 'č.p. ' . @$data->adresa_cp;
        } else if (empty($data->adresa_co) && empty($data->adresa_cp)) {
            $d_ulice = @$data->adresa_ulice;
        } else if (empty($data->adresa_co)) {
            $d_ulice = @$data->adresa_ulice . ' ' . @$data->adresa_cp;
        } else if (empty($data->adresa_ulice)) {
            $d_ulice = '';
        } else {
            $d_ulice = @$data->adresa_ulice . ' ' . @$data->adresa_co;
        }

        $d_adresa = $d_ulice . ', ' . @$data->adresa_psc . ' ' . @$data->adresa_mesto;
        if (trim($d_adresa) == ',')
            $d_adresa = '';

        if (empty($d_nazev))
            $d_nazev = "(bez názvu)";
        if (empty($d_osoba))
            $d_osoba = "(bez názvu)";
        if (empty($d_nazev_item))
            $d_nazev_item = "(bez názvu)";
        if (empty($d_osoba_item))
            $d_osoba_item = "(bez názvu)";

        // Sestaveni nazvu
        switch ($display) {
            case 'full':
                $res = $d_nazev . ', ' . $d_adresa;
                if (!empty($data->email)) {
                    $res .= ', ' . $data->email;
                }
                if (!empty($data->telefon)) {
                    $res .= ', ' . $data->telefon;
                }
                if (!empty($data->id_isds)) {
                    $res .= ', ' . $data->id_isds;
                }
                return $res;
            case 'osoba':
                return $d_osoba;
            case 'jmeno_item':
                return $d_nazev_item;
            case 'osoba_item':
                return $d_osoba_item;
            case 'adresa':
                return $d_adresa;
            case 'plna_adresa':
                $res = $d_nazev;
                if (!empty($d_adresa))
                    $res .= ', ' . $d_adresa;
                return $res;
            case 'formalni_adresa':
                return "$d_ulice\n$data->adresa_psc $data->adresa_mesto\n"
                        . Subjekt::stat($data->adresa_stat, 10);
            case 'plna_formalni_adresa':
                return "$d_nazev\n$d_ulice\n$data->adresa_psc $data->adresa_mesto\n"
                        . Subjekt::stat($data->adresa_stat, 10);
            case 'ulice':
                return $d_ulice;
            case 'mesto':
                return $data->adresa_psc . ' ' . $data->adresa_mesto;
            case 'email':
                return $d_nazev . ' <' . ( empty($data->email) ? 'nemá email' : $data->email ) . '>';
            case 'isds':
                return $d_nazev . ' (' . ( empty($data->id_isds) ? 'nemá datovou schránku' : $data->id_isds ) . ')';
            case 'telefon':
                return $d_nazev . ' (' . ( empty($data->telefon) ? 'nemá telefon' : $data->telefon ) . ')';

            case 'jmeno':
            default:
                return $d_nazev;
        }
    }

    public static function stat($kod = null, $select = 0)
    {
        $tb_staty = ':PREFIX:stat';

        $result = dibi::query('SELECT nazev,kod FROM %n', $tb_staty,
                        'WHERE stav=1 ORDER BY nazev')->fetchAll();

        $stat = array();
        // Dej CR na prvni misto v seznamu
        $stat['CZE'] = 'Česká republika';
        foreach ($result as $rdata) {
            $stat[$rdata->kod] = $rdata->nazev;
        }

        if (!is_null($kod))
            return array_key_exists($kod, $stat) ? $stat[$kod] : null;

        if ($select == 3)
            return array('' => 'v jakémkoli státě') + $stat;
        else if ($select == 10)
        // prazdna hodnota
            return "";

        return $stat;
    }

    public static function typ_subjektu($kod = null, $select = 0)
    {
        $typ = array('' => 'Neuveden / neznámý',
            'OVM' => 'Orgán veřejné moci',
            'FO' => 'Fyzická osoba',
            'PFO' => 'Fyzická osoba s podnikatelskou činností',
            'PO' => 'Firma, subjekt s podnikatelskou činností',
            'PFO_ADVOK' => 'PFO - advokáti',
            'PFO_DANPOR' => 'PFO - daňoví poradci',
            'PFO_INSSPR' => 'PFO - insolvenční správci',
            'PFO_AUDITOR' => 'PFO - statutární auditor',
            'OVM_REQ' => 'Podřízené OVM vzniklé na základě žádosti (§6 a 7)',
            'PO_REQ' => 'PO vzniklé na žádost',
            /* ISDS změny 26. 5. 2017 */
            'OVM_PO' => 'PO zapsána do Rejstříku OVM',
            'OVM_PFO' => 'PFO zapsána do Rejstříku OVM',
            'OVM_FO' => 'FO zapsána do Rejstříku OVM',
            'OVM_NOTAR' => 'zrušeno: OVM - notáři',
            'OVM_EXEKUT' => 'zrušeno: OVM - exekutoři',
            'PO_ZAK' => 'zrušeno: PO vzniklé ze zákona',
        );

        if (is_null($kod)) {
            if ($select == 3)
                $typ[''] = 'jakýkoli typ subjektu';

            return $typ;
        }

        return array_key_exists($kod, $typ) ? $typ[$kod] : null;
    }

    /**
     * Vrátí název souboru s obrázkem odpovídajícím zadanému typu subjektu.
     * @param string $typ
     * @return string
     */
    public static function img_name($typ)
    {
        if (substr($typ, 0, 3) == 'OVM')
            return 'ovm';
        if (substr($typ, 0, 3) == 'PFO')
            return 'pfo';
        if (substr($typ, 0, 2) == 'PO')
            return 'po';

        return 'fo';
    }

    public static function stav($stav = null)
    {
        $stavy = ['1' => 'aktivní', '2' => 'neaktivní'];

        if (is_null($stav))
            return $stavy;
        if (!is_numeric($stav))
            return null;

        return $stav == 1 ? $stavy[1] : $stavy[2];
    }

//    public function deleteAll()
//    {
//        $DokumentSubjekt = new DokumentSubjekt();
//        $DokumentSubjekt->deleteAll();
//
//        parent::deleteAll();
//    }
}

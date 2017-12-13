<?php

function revision_660_check()
{
    /*  Bohužel jedinečnost názvu spisů a spisových znaků nemůžeme pro stávající uživatele
      aplikace vynucovat.

      // --------------------------------------------------------------------
      $result = dibi::query('SELECT pocet FROM (SELECT COUNT(`nazev`) AS pocet FROM [spisovy_znak] GROUP BY `nazev`) subq WHERE pocet > 1');

      if (count($result))
      throw new \Exception('Kontrola integrity dat selhala. Název spisového znaku musí být jedinečný!');

      // --------------------------------------------------------------------
      $result = dibi::query('SELECT pocet FROM (SELECT COUNT(`nazev`) AS pocet FROM [spis] GROUP BY `nazev`) subq WHERE pocet > 1');

      if (count($result))
      throw new \Exception('Kontrola integrity dat selhala. Název spisu musí být jedinečný!');
     */

    // --------------------------------------------------------------------    
    $result = dibi::query('SELECT pocet FROM (SELECT COUNT(`code`) AS pocet FROM [user_role] GROUP BY `code`) subq WHERE pocet > 1');

    if (count($result))
        throw new \Exception('Kontrola integrity dat selhala. Kód role musí být jedinečný!');

    // --------------------------------------------------------------------
    $result = dibi::query('SELECT pocet FROM (SELECT COUNT(`dokument_id`) AS pocet FROM [dokument_to_spis] GROUP BY `dokument_id`) subq WHERE pocet > 1');

    if (count($result))
        throw new \Exception('Kontrola integrity dat selhala. Dokument nemůže být zařazen do více spisů!');

    // --------------------------------------------------------------------
    $result = dibi::query('SELECT pocet FROM (SELECT COUNT(`user_id`) AS pocet FROM [user_to_role] GROUP BY `user_id`, `role_id`) subq WHERE pocet > 1');

    if (count($result))
        throw new \Exception('Kontrola integrity dat selhala. Uživatel nemůže mít určitou roli přiřazenu vícekrát!');

    // --------------------------------------------------------------------
    $result = dibi::query('SELECT pocet FROM (SELECT COUNT(`role_id`) AS pocet FROM [user_acl] GROUP BY `role_id`, `rule_id`) subq WHERE pocet > 1');

    if (count($result))
        throw new \Exception('Kontrola integrity dat selhala. Uživatel nemůže mít určitou roli přiřazenu vícekrát!');
}

function revision_660_after()
{
    // zkus zmenit db strukturu, ale ignoruj, pokud by databaze hlasila chybu - kdyby zmena nebyla mozna
    try {
        dibi::query('ALTER TABLE `spisovy_znak` ADD UNIQUE KEY `nazev` (`nazev`)');
    } catch (\Exception $e) {
        
    }

    try {
        dibi::query('ALTER TABLE `spis` ADD UNIQUE KEY `nazev` (`nazev`)');
    } catch (\Exception $e) {
        
    }
}

function revision_700_check()
{
    // --------------------------------------------------------------------    
    $result = dibi::query("SELECT id FROM [user_role] WHERE [code] = 'referent'");
    $pole = $result->fetch();
    if (!$pole || $pole['id'] != 4)
        throw new \Exception('Role "referent" je chybně definována!');
}

function revision_810_after()
{
    $res = dibi::query('SELECT * FROM [sestava]');

    foreach ($res as $sestava) {

        $sloupce = array(
            '-1' => 'smer',
            '0' => 'cislo_jednaci',
            '1' => 'spis',
            '2' => 'datum_vzniku',
            '3' => 'subjekty',
            '4' => 'cislo_jednaci_odesilatele',
            '5' => 'pocet_listu',
            '6' => 'pocet_priloh',
            '7' => 'pocet_nelistu',
            '8' => 'nazev',
            '9' => 'vyridil',
            '10' => 'zpusob_vyrizeni',
            '11' => 'datum_odeslani',
            '12' => 'spisovy_znak',
            '13' => 'skartacni_znak',
            '14' => 'skartacni_lhuta',
            '15' => 'zaznam_vyrazeni',
            '16' => 'popis',
            '17' => 'poznamka_predani',
            '18' => 'prazdny_sloupec'
        );

        $zobr = isset($sestava->zobrazeni_dat) ? unserialize($sestava->zobrazeni_dat) : false;
        if ($zobr === false)
            $zobr = array();

        // nastav vychozi hodnoty
        if (!isset($zobr['sloupce_poznamka']))
            $zobr['sloupce_poznamka'] = false;
        if (!isset($zobr['sloupce_poznamka_predani']))
            $zobr['sloupce_poznamka_predani'] = false;
        if (!isset($zobr['sloupce_smer_dokumentu']))
            $zobr['sloupce_smer_dokumentu'] = true;
        if (!isset($zobr['sloupce_prazdny']))
            $zobr['sloupce_prazdny'] = false;

        // vyber sloupce dle stare definice sestavy
        if (!$zobr['sloupce_poznamka'])
            unset($sloupce[16]);
        if (!$zobr['sloupce_smer_dokumentu'])
            unset($sloupce[-1]);
        if (!$zobr['sloupce_poznamka_predani'])
            unset($sloupce[17]);
        if (!$zobr['sloupce_prazdny'])
            unset($sloupce[18]);

        $sloupce_string = implode(',', $sloupce);

        unset($zobr['sloupce_poznamka']);
        unset($zobr['sloupce_poznamka_predani']);
        unset($zobr['sloupce_smer_dokumentu']);
        unset($zobr['sloupce_prazdny']);

        $res = dibi::query('UPDATE [sestava] SET [sloupce] = %s, [zobrazeni_dat] = %s WHERE [id] = %i',
                        $sloupce_string, serialize($zobr), $sestava->id);
    }
}

function revision_870_after()
{
    global $client;

    deleteDir($client->get_path() . "/sessions/");
}

/**
 * Pozn.: Toto mohlo být řešeno jako subquery, ale to mě tehdy nenapadlo.
 * Teď už nemá cenu tento kód přepisovat.
 */
function revision_890_after()
{
    $res = dibi::query('SELECT d.[id] FROM [dokument] d        
JOIN [epodatelna] e ON e.[dokument_id] = d.[id] AND e.[epodatelna_typ] = 0
WHERE [email_id] IS NOT NULL');
    $ids = $res->fetchPairs();

    dibi::query('UPDATE [dokument] SET [zpusob_doruceni_id] = 1 WHERE [id] IN %in', $ids);

    $res = dibi::query('SELECT d.[id] FROM [dokument] d        
JOIN [epodatelna] e ON e.[dokument_id] = d.[id] AND e.[epodatelna_typ] = 0
WHERE [isds_id] IS NOT NULL');
    $ids = $res->fetchPairs();

    dibi::query('UPDATE [dokument] SET [zpusob_doruceni_id] = 2 WHERE [id] IN %in', $ids);
}

function revision_940_after()
{
    $res = dibi::query("SELECT [id] FROM [dokument_typ] WHERE [nazev] LIKE %s", '%- doručeno%');
    $ids = $res->fetchPairs();

    foreach ($ids as $id)
        dibi::query("DELETE IGNORE FROM [dokument_typ] WHERE [id] = %i", $id);
}

function revision_960_after()
{
    $res = dibi::query("SELECT * FROM [osoba] WHERE [email] != '' AND [email] IS NOT NULL");
    $osoby = $res->fetchAll();

    $all_ok = true;
    foreach ($osoby as $osoba) {
        if (!Nette\Utils\Validators::isEmail($osoba->email)) {
            $all_ok = false;
            echo "Chyba: $osoba->jmeno $osoba->prijmeni - $osoba->email\n";
        }
    }

    if ($all_ok)
        echo "Všechny e-mailové adresy zaměstnanců jsou v pořádku.";
    else
        throw new \Exception("Prosíme opravte tyto chyby v e-mailových adresách zaměstnanců.");
}

function revision_990_check()
{
    $res = dibi::query("SELECT [id], [jid] FROM [dokument] WHERE [spisovy_znak_id] IS NOT NULL AND [spisovy_znak_id] NOT IN"
                    . " (SELECT [id] FROM [spisovy_znak])");

    if (count($res)) {
        echo "Nalezena chyba v datech! Je nutné ji ručně opravit.\n";
        echo "Jedná se o následující dokumenty:\n\n";
        foreach ($res as $dok)
            echo $dok->jid . "\n";
        return false;
    }

    return true;
}

function revision_1060_after()
{
    $m = new SpisModel();
    $m->rebuildIndex();
}

function revision_1410_before()
{
    $db_name = dibi::getConnection()->getConfig('database');

    $res = dibi::query('SELECT TABLE_NAME, CONSTRAINT_NAME FROM information_schema.KEY_COLUMN_USAGE WHERE CONSTRAINT_SCHEMA = %s AND REFERENCED_TABLE_NAME IS NOT NULL',
                    $db_name)->fetchAll();
    foreach ($res as $row) {
        $table = $row->TABLE_NAME;
        $constraint = $row->CONSTRAINT_NAME;
        dibi::query('ALTER TABLE %n DROP FOREIGN KEY %n', $table, $constraint);
    }

    $res = dibi::query('SELECT TABLE_NAME, INDEX_NAME FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = %s AND INDEX_NAME LIKE %s',
                    $db_name, 'fk_%')->fetchAll();
    foreach ($res as $row) {
        $table = $row->TABLE_NAME;
        $index = $row->INDEX_NAME;
        dibi::query('ALTER TABLE %n DROP KEY %n', $table, $index);
    }

    echo "Integritní omezení byla všechna úspěšně smazána.";
}

function revision_1420_before()
{
    $duplicates = dibi::query("SELECT [dokument_id], [subjekt_id] FROM [dokument_to_subjekt] GROUP BY [dokument_id], [subjekt_id] HAVING COUNT(*) > 1")->fetchAll();
    if (empty($duplicates)) {
        echo "Žádné chyby nenalezeny.";
        return;
    }

    echo "Nalezeny duplicity v přiřazení subjektů.\n" .
    "Vypisuji ID dotčených dokumentů:\n";

    foreach ($duplicates as $row) {
        echo $row->dokument_id . "\n";

        dibi::query("DELETE FROM [dokument_to_subjekt] WHERE [dokument_id] = %i AND [subjekt_id] = %i",
                $row->dokument_id, $row->subjekt_id);

        $new_record = ['dokument_id' => $row->dokument_id,
            'subjekt_id' => $row->subjekt_id,
            'user_id' => 1,
            'typ' => 'AO',
            'date_added' => new \DateTime
        ];
        dibi::insert("dokument_to_subjekt", $new_record)->execute();
    }

    echo "Chyby byly opraveny.";
}

function revision_1460_after()
{
    $res = dibi::query("SHOW COLUMNS FROM [acl_role_to_privilege] LIKE 'id'");
    if (count($res))
        dibi::query(
                'ALTER TABLE [acl_role_to_privilege]
    DROP PRIMARY KEY,
    DROP COLUMN [id],
    ADD PRIMARY KEY ([role_id], [privilege_id]);');
}

function revision_1500_after()
{
    $m = new SpisovyZnak();
    $m->rebuildIndex();
    echo "Hotovo.";
}

function revision_1520_after()
{
    $res = dibi::query("SELECT [id], [druh_zasilky] FROM [dokument_odeslani] WHERE [druh_zasilky] IS NOT NULL");
    if (!$res)
        return; // empty table

    $res = $res->fetchPairs();
    foreach ($res as $id => $druh) {
        $druh = unserialize($druh);
        sort($druh, SORT_NUMERIC);
        dibi::query("UPDATE [dokument_odeslani] SET [druh_zasilky] = %s WHERE [id] = $id",
                implode(',', $druh));
    }
}

function revision_1615_after()
{
    $names = dibi::query("SELECT [nazev] FROM [file] WHERE [nazev] LIKE 'ep-isds-%.zfo'",
                    "AND [real_path] LIKE '%EP-O-%'", "GROUP BY [nazev] HAVING COUNT(*) > 1 ")->fetchPairs();

    foreach ($names as $name) {
        $ids = dibi::query("SELECT [id] FROM [file] WHERE [nazev] = %s ORDER BY [id] ASC",
                        $name)->fetchPairs();
        array_shift($ids);
        dibi::query("DELETE FROM [file] WHERE [id] IN %in", $ids);
    }
}

function revision_1670_after()
{
    $admin_role_id = dibi::query("SELECT [id] FROM [acl_role] WHERE [code] = 'admin'")->fetchSingle();
    $superadmin_role_id = dibi::query("SELECT [id] FROM [acl_role] WHERE [code] = 'superadmin'")->fetchSingle();    
    if (!$superadmin_role_id)
        return;

    // Nastav, že role není fixní, aby bylo možné ji smazat
    dibi::query("UPDATE [acl_role] SET [fixed] = 0 WHERE [id] = $superadmin_role_id");
    
    $superadmins = dibi::query("SELECT [user_id] FROM [user_to_role] WHERE [role_id] = $superadmin_role_id")->fetchPairs();
    if (!$superadmins)
        return;
    
    foreach ($superadmins as $superadmin) {
        $res = dibi::query("SELECT COUNT(*) FROM [user_to_role] WHERE [user_id] = $superadmin AND [role_id] = $admin_role_id")->fetchSingle();
        if ($res) {
            // uživatel je zároveň superadmin a admin
            dibi::query("DELETE FROM [user_to_role] WHERE [user_id] = $superadmin AND [role_id] = $superadmin_role_id");
        } else {
            // uživatel je pouze superadmin
            dibi::query("UPDATE [user_to_role] SET [role_id] = $admin_role_id WHERE [user_id] = $superadmin AND [role_id] = $superadmin_role_id");
        }
        // vynuť nové přihlášení změněného uživatele
        dibi::query("UPDATE [user] SET [force_logout] = 1 WHERE [id] = $superadmin");
    }
        
}
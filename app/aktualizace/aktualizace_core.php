<?php

namespace Spisovka;

class Updates
{

    protected static $update_dir;
    protected static $alter_scripts = array();
    protected static $revisions = array();
    protected static $descriptions = array();
    protected static $hooks = array();

    public static function init()
    {
        self::$update_dir = APP_DIR . '/aktualizace/';
        require self::$update_dir . 'scripts.php';
    }

    public static function get_update_dir()
    {
        return self::$update_dir;
    }

    /**
     *  $contents bude obsahovat obsah souboru v pripade, ze je soubor v ZIP archivu
     */
    protected static function _process_file($filename, $contents)
    {
        if ($filename == 'information.txt') {
            $info = file(self::$update_dir . $filename);
            if ($info)
                self::$descriptions = self::_parse_info_file($info);
            return;
        }

        $matches = [];
        if (preg_match('/([0-9]+)\.sql/', $filename, $matches)) {
            $revision = $matches[1];
            self::$revisions[] = $revision;

            $sql_source = $contents ?: file_get_contents(self::$update_dir . $filename);
            self::$alter_scripts[$revision] = self::_parse_sql($sql_source);
        }
    }

    /**
     * 
     * @param string $data
     * @return array SQL commands, including comments
     */
    protected static function _parse_sql($data)
    {
        $queries = [];
        $query = '';
        $lines = explode("\n", $data);
        foreach ($lines as $line) {
            if (substr($line, 0, 2) === '--')
                continue;

            $line = rtrim($line);
            $query .= $line . "\n";
            if (substr($line, -1) == ';') {
                $queries[] = trim($query);
                $query = '';
            }
        }

        return $queries;
    }

    /**
     * Find PHP snippets
     */
    private static function _find_hooks()
    {
        self::$hooks = [];
        $functions = get_defined_functions();
        $matches = [];
        $types = ['check', 'before', 'after'];
        foreach ($functions['user'] as $func_name) {
            if (preg_match('/revision_(\d+)_([a-z]+)$/', $func_name, $matches)) {
                $revision = $matches[1];
                $type = $matches[2];
                if (!in_array($type, $types))
                    continue;
                self::$revisions[] = $revision;
                self::$hooks[$revision][$type] = $func_name;
            }
        }
    }

    public static function find_updates()
    {
        self::$alter_scripts = array();
        self::$revisions = array();

        $dir_handle = opendir(self::$update_dir);
        if ($dir_handle === FALSE)
            throw new \Exception(__METHOD__ . "() - nemohu otevřít adresář " . self::$update_dir);

        $zip = new \ZipArchive;
        $filename = self::$update_dir . 'db_scripts.zip';
        if ($zip->open($filename) !== TRUE)
            throw new \Exception(__METHOD__ . "() - nemohu otevřít soubor $filename.");

        for ($i = 0; $i < $zip->numFiles; $i++) {
            $stat = $zip->statIndex($i);
            $filename = $stat['name'];
            self::_process_file($filename, $zip->getFromName($filename));
        }

        while (($filename = readdir($dir_handle)) !== false) {
            self::_process_file($filename, null);
        }

        closedir($dir_handle);

        self::_find_hooks();

        // setridit pole, aby se alter skripty spoustely ve spravnem poradi
        self::$revisions = array_unique(self::$revisions);
        sort(self::$revisions, SORT_NUMERIC);

        return array('revisions' => self::$revisions, 'alter_scripts' => self::$alter_scripts,
            'descriptions' => self::$descriptions, 'hooks' => self::$hooks);
    }

    protected static function _parse_info_file($info)
    {
        $rev = 0;
        $a = array();
        $matches = [];

        foreach ($info as $line) {
            if ($line{0} == '[')
                if (preg_match('/^\[(\d+)\]/', $line, $matches) == 1) {
                    $rev = $matches[1];
                    continue;
                }

            // ignoruj prazdny radek
            /* if (trim($line) === '')
              continue; */

            if (!isset($a[$rev]))
                $a[$rev] = '';
            $a[$rev] .= $line;
        }

        return $a;
    }

    public static function find_clients()
    {
        $clients = array();
        if (Hosting::detect()) {
            $names = file(dirname(APP_DIR) . "/clients/list");
            if ($names)
                foreach ($names as $name) {
                    $name = trim($name);
                    $client_dir = "/var/www/vhosts/$name.mojespisovka.cz/httpdocs";
                    $clients[$client_dir] = "$name";
                }
        } else {
            $client_dir = dirname(APP_DIR) . "/client";
            $clients[$client_dir] = "Samostatná instalace - $client_dir";
        }

        asort($clients);     // Setrid klienty podle abeceny  
        return $clients;
    }

}

class Client_To_Update
{

    private $db_config;
    private $path;   // cesta k adresari klienta v souborovem systemu

    public function __construct($path_to_client)
    {
        $this->path = $path_to_client;
    }

    public function get_db_config()
    {
        if (!$this->db_config) {
            // pri volani z aktualizacniho skriptu nebude promenna nastavena
            $config = GlobalVariables::get('database');
            if ($config) {
                $this->db_config = $config;
            } else if (is_file("{$this->path}/configs/database.neon")) {
                $data = (new ConfigDatabase("{$this->path}/configs/"))->get();
                $this->db_config = $data->parameters->database;
                $this->db_config->profiler = false;
            } else {
                $ini = parse_ini_file("{$this->path}/configs/system.ini", true);
                if ($ini !== FALSE)
                    $this->db_config = array(
                        "driver" => $ini['common']['database.driver'],
                        "host" => $ini['common']['database.host'],
                        "username" => $ini['common']['database.username'],
                        "password" => $ini['common']['database.password'],
                        "database" => $ini['common']['database.database'],
                        "charset" => $ini['common']['database.charset'],
                        "prefix" => $ini['common']['database.prefix'],
                        "profiler" => false
                    );
                else
                    throw new \Exception("Nemohu přečíst konfigurační soubor system.ini");
            }
        }

        return $this->db_config;
    }

    public function get_path()
    {
        return $this->path;
    }

    public function connect_to_db()
    {
        $db_config = $this->get_db_config();
        try {
            dibi::connect($db_config);
            dibi::getSubstitutes()->{'PREFIX'} = null;
        } catch (DibiException $e) {
            $e->getMessage();
            throw new \Exception("Nepodařilo se připojit k databázi. Klienta nelze aktualizovat.");
        }
    }

    function get_revision_number()
    {
        $result = dibi::query("SELECT [value] FROM [settings] WHERE [name] = 'db_revision'");
        return $result->fetchSingle();
    }

    function update_revision_number($revision)
    {
        dibi::query('UPDATE [settings] SET [value] = %i', $revision,
                "WHERE [name] = 'db_revision'");
        return true;
    }

    /**
     * Check if we need to rename database tables
     * @return boolean   true = rename procedure was already done
     */
    public function check_rename_db_tables()
    {
        try {
            $value = dibi::query("SELECT [value] FROM [settings] WHERE [name] = 'db_tables_renamed'")->fetchSingle();
            return $value === 'true';
        } catch (\Exception $e) {
            $e->getMessage();
            return false;
        }
    }

    public function rename_db_tables()
    {
        $config = $this->get_db_config();
        $prefix = $config['prefix'];
        if (empty($prefix))
            echo "Tabulky aplikace nemají prefix, není potřeba provádět přejmenování.";
        else {
            $tables = dibi::getDatabaseInfo()->getTableNames();
            foreach ($tables as $table)
                if (strncmp($table, $prefix, strlen($prefix)) !== 0) {
                    echo "V databázi nalezena tabulka '$table', která nepatří aplikaci! <br />Nelze pokračovat. Zjednejte prosím nápravu.";
                    return;
                }

            // Oprava bugu v definici tabulky spis (foreign key v nekterych databazich je, v jinych ne)
            try {
                dibi::query("ALTER TABLE %n DROP FOREIGN KEY [spis_ibfk_1]", "{$prefix}spis");
            } catch (\Exception $e) {
                // ocekava se vyjimka, ignoruj
            }

            $error = false;
            foreach ($tables as $table) {
                $new_name = substr($table, strlen($prefix));
                try {
                    dibi::query("RENAME TABLE [$table] TO [$new_name]");
                } catch (\Exception $e) {
                    $e->getMessage();
                    $error = true;
                }
            }

            echo 'Tabulky byly přejmenovány.';
            if ($error)
                throw new \Exception('Minimálně u jedné tabulky přejmenování selhalo. Je nutná odborná oprava.');
        }

        // Úspěch - hotovo nebo nebylo potřeba nic dělat
        dibi::query("INSERT INTO [settings] VALUES ('db_tables_renamed', 'true')");

        echo " Spusťte prosím aktualizační skript znovu.";
    }

}

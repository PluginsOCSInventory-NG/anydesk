<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_anydesk()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `anydesk`");
    $commonObject -> sqlQuery("CREATE TABLE `anydesk` (
                              `ID` INT(11) NOT NULL AUTO_INCREMENT,
                              `HARDWARE_ID` INT(11) NOT NULL,
                              `ADID` VARCHAR(255) DEFAULT NULL,
                              `VERSION` VARCHAR(255) DEFAULT NULL,
                              `ALIAS` VARCHAR(255) DEFAULT NULL,
                              PRIMARY KEY  (`ID`,`HARDWARE_ID`)
                              ) ENGINE=INNODB;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_anydesk()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `anydesk`");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_anydesk()
{

}

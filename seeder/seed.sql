DROP TABLE IF EXISTS utente;
DROP TABLE IF EXISTS bene;
DROP TABLE IF EXISTS acquisto;
DROP TABLE IF EXISTS modo;

CREATE TABLE utente (
    email varchar(35) NOT NULL,
    username varchar(25) NOT NULL,
    nome varchar(25) NOT NULL,
    cognome varchar(25) NOT NULL,
    ruolo enum('user','admin') DEFAULT 'user',
    credito int(10) NOT NULL,
    PRIMARY KEY(email)
);


CREATE TABLE bene (
    id int(10) NOT NULL AUTO_INCREMENT,
    nome varchar(20) NOT NULL,
    tipo enum('manoscritto','cartografia storica') DEFAULT 'manoscritto',
    anno int(4) NOT NULL,
    prezzo int(3) NOT NULL,
    nDownload int(3),
    PRIMARY KEY(id)
);


CREATE TABLE acquisto (
    id int(10) NOT NULL AUTO_INCREMENT,
    formato enum('jpg','tiff','png') DEFAULT 'jpg',
    email_compr varchar(35) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(email_compr) REFERENCES utente (email) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE modo (
    id int(10) NOT NULL AUTO_INCREMENT,
    id_acquisto int(10) NOT NULL,
    id_bene int(10) NOT NULL,
    tipo_acq enum('download originale', 'download aggiuntivo') DEFAULT 'download originale',
    PRIMARY KEY(id),
    FOREIGN KEY(id_acquisto) REFERENCES acquisto (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_bene) REFERENCES bene (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO utente (email, username, nome, cognome, ruolo, credito) VALUES
    ('rossiMario@gmail.com', 'RosMar', 'Mario', 'Rossi', 'user',150),
    ('luigiVerdi@alice.it', 'VerLug', 'Luigi', 'Verdi', 'user',120),
    ('mariaBianchi@gmail.com', 'Mary', 'Maria', 'Bianchi', 'user',15),
    ('cass.lof@alice.it', 'Cassidy', 'Cassandra', 'Loffanzi', 'user',0),
    ('giovi@alice.it', 'Giova', 'Giovanni', 'Saluti','user',23),
    ('babiFre@alice.it', 'Barbara', 'Barbara', 'Frescati', 'admin',999);

INSERT INTO bene (id,nome,tipo,anno,prezzo,nDownload) VALUES 
    (1,'Aristotle_latin_manuscript.jpg','manoscritto',355,28,0),
    (2,'cart_Roma_Capitale.jpg','cartografia storica',427,36,1),
    (3,'fiume_PO.jpg','cartografia storica',1576,10,0),
    (4,'Karl-VI-Praesentirt-per-notarium.jpg','manoscritto',1370,120,0),
    (5,'Tibullo-Albio-cavaliere-Romano-elogio1°-tradotto-dal-latino.jpg','manoscritto',800,85,2);

INSERT INTO acquisto (id,formato,email_compr) VALUES
    (1,'jpg','rossiMario@gmail.com'),
    (2,'png','giovi@alice.it'),
    (3,'jpg','giovi@alice.it');

INSERT INTO modo (id_acquisto,id_bene,tipo_acq) VALUES 
    (1,1,'download origiale'),
    (2,4,'download originale'),
    (3,4,'download aggiuntivo');
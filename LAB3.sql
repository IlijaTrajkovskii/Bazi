CREATE TABLE Korisnik (
     k_ime INT PRIMARY KEY ,
    ime varchar(50),
    prezime varchar(50),
    tip INT ,
    pretplata INT,
    datum_reg date,
    tel_broj varchar(12),
    email varchar(50),

    CONSTRAINT datumReg_proverka check (datum_reg BETWEEN '2023-01-01' AND '2024-12-31')

);


CREATE TABLE Premium_korisnik (
    k_ime INT PRIMARY KEY ,
    datum date,
    procent_popust REAL DEFAULT 20,

    CONSTRAINT Premium_korisnik_FK FOREIGN KEY (k_ime) REFERENCES  Korisnik(k_ime)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Profil (
    k_ime INT,
    ime varchar(50),
    datum date,

    CONSTRAINT Profil_PK PRIMARY KEY (k_ime,ime),
    CONSTRAINT Profil_FK FOREIGN KEY (k_ime) REFERENCES Korisnik(k_ime) ON DELETE CASCADE ON UPDATE CASCADE


);

CREATE TABLE Video_zapis (
    naslov INT PRIMARY KEY ,
    jazik varchar(50) DEFAULT 'English',
    vremetraenje int,
    datum_d date,
    datum_p date,

    constraint datum_check CHECK (datum_d >= datum_p)
);

CREATE TABLE Video_zapis_zanr (
    naslov INT,
    zanr varchar(50),

    CONSTRAINT Video_zapis_zanr_PK PRIMARY KEY (naslov,zanr),
    CONSTRAINT Video_zapis_zanr_FK FOREIGN KEY (naslov) REFERENCES Video_zapis(naslov) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE Lista_zelbi (
    naslov INT,
    k_ime INT,
    ime varchar(50),

    CONSTRAINT Lista_zelbi_PK PRIMARY KEY (naslov,k_ime,ime),

    CONSTRAINT Video_zapis_FK FOREIGN KEY (naslov) REFERENCES Video_zapis(naslov) ON DELETE CASCADE ON UPDATE CASCADE ,
    CONSTRAINT Profil_FK FOREIGN KEY (k_ime,ime) REFERENCES Profil(k_ime,ime) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Preporaka (
    ID INT PRIMARY KEY ,
    k_ime_od INT,
    k_ime_na INT,
    naslov INT DEFAULT -1, -- Treba da bide 'Deleted' no bidejki e INT sedi -1
    datum date,
    komentar varchar(250) NOT NULL ,
    ocena INT,

    CONSTRAINT Korisnik_od_FK FOREIGN KEY (k_ime_od) REFERENCES Korisnik(k_ime)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT Korisnik_na_FK FOREIGN KEY (k_ime_na) REFERENCES Korisnik(k_ime)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT video_z_FK FOREIGN KEY (naslov) REFERENCES Video_zapis(naslov)
        ON DELETE SET DEFAULT
        ON UPDATE CASCADE,

    CONSTRAINT ocena_proverka CHECK (ocena BETWEEN 1 AND 5),
    CONSTRAINT datum_proverka CHECK ( datum >= '2022-12-07' ) -- proveri da ne treba >

);


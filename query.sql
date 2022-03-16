/*Query 1:
Contare il numero di lingue in cui le release contenute nel database sono scritte (il risultato
deve contenere soltanto il numero delle lingue, rinominato “Numero_Lingue”).*/
select count (distinct r.language) as Numero_Lingue
from release r
/*
1.Informazioni presenti nella tabella release
2.l'attributo language
3.Distinguere e contare le lingue presenti nella tabella che contiene le release
4.
5.
6.Ho eseguito la query select distinct language from release per vedere quanti identificato di lingue erano presenti e li ho contati ed ho controllato che la quantità fosse uguale al valore presente nell' attributo Numero_Lingue della query select count (distinct r.language) as Numero_Lingue from release r 
*/

/*Query 2:
Elencare gli artisti che hanno cantato canzoni in italiano (il risultato deve contenere il nome
dell’artista e il nome della lingua).*/
select distinct l.name, ac.name
from release r, artist_credit ac, language l, medium m, track t
where r.artist_credit = ac.id and l.id = r.language and lower(l.name) = 'italian'
and m.release = r.id and t.medium = m.id
/*
1.Informazioni presenti in release, artist_credit, language, medium e track
2.Gli attributi artist_credit e language in release, id e name in language, e id in artist_credit
3.Correlare release e artist_credit tramite gli attributi artist_credit e id per ottenere le
release di ogni artista persente in artist_credit, ampliare questa tabella aggiungendo gli id dei
linguaggi presenti in language e prendere in considerazione solo le righe che contengono italian
(l' ho prima trasformato in minuscolo per evitare che non prendesse in considerazione valori
diversi da come avessi scritto italian), ho aggiunto anche i valori di medium per arrivare alle
tracce presenti in track
4.
5.
6.Ho provato a eseguirla, ma non ha restituito alcun risultato, ma sono convinto sia corretta

/*Query 3:
Elencare le release di cui non si conosce la lingua (il risultato deve contenere soltanto il
nome della release).*/
select distinct r.name
from release r
where r.language IS NULL
order by r.name
/*
1.Informazioni presenti in release
2.I campi language e name in release
3.Trovare innanzitutto tra le release quelle che avevano l' identificatore della relativa lingua
settato a null e considerare solo i nomi di queste release presenti in name
4.Che siano null le lingue delle righe che vogliamo estrarre
5.
6.Ho controllato i nome delle release in cui i campi r.language fossero nulli della query select distinct * from release r comparissero nella query risultante
*/

/*Query 4:
Elencare le release che nel nome hanno la parola “love”, in qualsiasi posizione (quindi anche
in prima posizione; il risultato deve contenere soltanto il nome della release).*/
select distinct r.name
from release r
where lower(r.name) LIKE '%love%' or lower(r.name) LIKE 'love%' or lower(r.name) LIKE '%love'
order by r.name

select distinct r.name
from release r
where UPPER(r.name) LIKE '%LOVE%'
order by r.name
/*
1.Informazioni presenti in release
2.Il campo name di release
3.Ottenere le righe con la parte name che contenga love e uso lower per fare in modo che ci sia
love senza tener conto di maiuscole o minuscole
4.
5.
6.Ho eseguito le due query e ho controllato che i risultati fossero uguali
*/

/*Query 5:
Elencare tutti gli pseudonimi di Prince con il loro tipo, se disponibile (il risultato deve
contenere lo pseudonimo dell'artista, il nome dell’artista (cioè Prince) e il tipo di pseudonimo
(se disponibile)).*/
select aa.name, a.name, aa.type
from artist a, artist_alias aa
where lower(a.name) = 'prince' and aa.artist = a.id
/*
1.Informazioni presenti in artist e artist_alias
2.L' attributo name di artist reso minuscolo che fosse uguale a prince minuscolo e che il campo
id di artist fosse uguale ad artist_alias.artist
3.Prima incastrare le tabelle artist_alias e artist sui campi artist e id, e infine tener conto
solo delle righe che contengono la stringa prince
4.Sì, che i campi artist_alias.artist e artist.id contenessero le stesse informazioni
5.
6.L'ho eseguita e ho visto che a.name contenesse in tutte le righe la parola Prince
*/

/*Query 6:
Elencare le release di gruppi inglesi ancora in attività (il risultato deve contenere il nome del
gruppo e il nome della release e essere ordinato per nome del gruppo e nome della release)*/
select distinct ac.name, r.name
from release_country rc, country_area ca, area a, release r, artist_credit ac
where rc.country = ca.area and a.id = ca.area and r.id = rc.release and ac.id = r.artist_credit
and a.ended = false and lower(a.name) = 'united kingdom'
order by ac.name, r.name
/*
1.Informazioni presenti in release_country, country_area, area, release e artist_credit
2.Ho controllato country di release_country che fosse uguale ad area di country_area, id di area 
che fosse uguale a area di country_area, id di artist_credit uguale a artist_credit di release,
ed infine id di release uguale a release di release_country
3.Fare delle join per ottenere le informazioni riguadanti a tutti i gruppi, nello specifico
inglesi(regno unito) ed in attività e selezionare tra le nazioni il regno unito.
4.
5.
6.L'ho eseguita e controllato che nel campo a.name ci fosse in ogni istanza united kingdom
e eseguendo la query: 
select distinct ac.name, r.name, a.name
from release_country rc, country_area ca, area a, release r, artist_credit ac
where rc.country = ca.area and a.id = ca.area and r.id = rc.release and ac.id = r.artist_credit
and a.ended = false
order by ac.name, r.name
e vedendo qualche release con united kingdom comparisse nella query risolutiva
*/

/*Query 7:
Trovare le release in cui il nome dell’artista è diverso dal nome accreditato nella release (il
risultato deve contenere il nome della release, il nome dell’artista accreditato (cioè
artist_credit.name) e il nome dell’artista (cioè artist.name))*/
select distinct ac.name, a.name, r.name
from release r, artist_credit_name acn, artist_credit ac, artist a
where r.artist_credit = ac.id and acn.artist_credit = ac.id 
and acn.artist = a.id and ac.name != a.name
/*
1.Informazioni presenti in release, artist_credit_name, artist_credit e artist
2.Ho controllato che artist_credit di release fosse uguale all' attributo id di artist_credit,
che il campo artist_credit di artist_credit_name avesse le stesse informazioni presenti in 
id di artist_credit e artist di artist_credit_name fosse lo stesso per id di artist. Infine 
che il nome dell’artista fosse diverso dal nome accreditato nella release
3.Incrociare le informazioni tra le tabelle release, artist_credit_name, artist_credit e artist
e perchè vogliamo tutti gli artisti e tutti gli artisti accreditati e che siano diversi per lo 
stesso artista
4.
5.
6.L'ho eseguita ed ho controllato che effettivamente i campi ac.name e a.name fossero diversi
tra le istanze presenti e nella correttezza della logica della query
*/

/*Query 8:
Trovare gli artisti con meno di tre release (il risultato deve contenere il nome dell’artista ed
il numero di release).*/
select distinct ac.name, count(*) as qrelease
from release r, artist_credit ac
where r.artist_credit = ac.id
group by ac.name
having count(*) < 3
order by qrelease
/*
1.Informazioni presenti in release e artist_credit
2.Ho controllato che la chiave esterna r.artist_credit corrispondesse a ac.id
3.Incrociare le informazioni in release e artist_credit e contare le volte in cui compare
ac.name
4.
5.
6.Ho controllato che, dopo aver eseguito la query, nel campo qrelease ci fossero valori inferiori
al 3
*/


/*Query 9:
Trovare la registrazione più lunga di un’artista donna (il risultato deve contenere il nome
della registrazione, la sua durata in minuti e il nome dell’artista; tenere conto che le durate
sono memorizzate in millesimi di secondo) (scrivere due versioni della query con e senza
operatore aggregato MAX).*/

select artisti_donne_length.nomea, artisti_donne_length.nomer, artisti_donne_length.length
from
    (select a.name as nomea, r.name as nomer, max(r.length) as length, row_number() over (order by max(r.length) desc) as riga
    from artist a, gender g, artist_credit_name acn, artist_credit ac, 
    recording r
    where a.gender = g.id and a.gender = 2
    and acn.artist = a.id and acn.artist_credit = r.artist_credit
    and r.length is not null
    group by a.name, r.name
    order by max(r.length) desc
    ) as artisti_donne_length
where artisti_donne_length.riga = 1
/*
1.Informazioni presenti in artist, gender, artist_credit_name, artist_credit e recording
2.Ho controllato che i valori tra le chiavi primarie ed esterne seguenti fossero gli stessi:
a.gender = g.id, acn.artist = a.id e acn.artist_credit = r.artist_credit. E che la lunghezza
delle release prese in considerazione non fosse null con r.length is not null e che gli artisti
presi in considerazione fossero delle donne con a.gender = 2 (dopo aver fatto select * from 
gender e notare che il valore 2 fosse l' identificato per le donne)
3.Ho estratto e ordinato le registrazioni delle artiste donne in ordine decrescente per lunghezza (che non doveva essere nulla) 
massima di registrazione:
select a.name as nomea, r.name as nomer, max(r.length) as length, row_number() over (order by max(r.length) desc) as riga
    from artist a, gender g, artist_credit_name acn, artist_credit ac, 
    recording r
    where a.gender = g.id and a.gender = 2
    and acn.artist = a.id and acn.artist_credit = r.artist_credit
    and r.length is not null
    group by a.name, r.name
    order by max(r.length) desc
Ho selezionato la riga con il valore restituito dalla funzione row_number(), ridenominata in riga, pari a 1:
select artisti_donne_length.nomea, artisti_donne_length.nomer, artisti_donne_length.length
from
    (select a.name as nomea, r.name as nomer, max(r.length) as length, row_number() over (order by max(r.length) desc) as riga
    from artist a, gender g, artist_credit_name acn, artist_credit ac, 
    recording r
    where a.gender = g.id and a.gender = 2
    and acn.artist = a.id and acn.artist_credit = r.artist_credit
    and r.length is not null
    group by a.name, r.name
    order by max(r.length) desc
    ) as artisti_donne_length
where artisti_donne_length.riga = 1
4.
5.Ho riportato di seguito diverse versioni di query
6.L'ho eseguita e ne ho fatte altre che ho riportato di seguito
*/

select artiste_donne_numerate.nomea, artiste_donne_numerate.nomer, artiste_donne_numerate.length
from
    (select distinct a.name as nomea, a.id, a.gender, r.name as nomer, r.length, row_number() over (order by r.length desc) as riga
    from artist a, gender g, artist_credit_name acn, artist_credit ac, recording r
    where a.gender = g.id and a.gender = 2
    and acn.artist = a.id and acn.artist_credit = r.artist_credit
    and r.length is not null
    order by length desc
     ) as artiste_donne_numerate
where artiste_donne_numerate.riga = 1
/**/

select artisti_femmina_lunghezze.nomea, artisti_femmina_lunghezze.length/60000 length, artisti_femmina_lunghezze.nomer
from
    (select artisti_femmina.id, artisti_femmina.gender, artisti_femmina.name as nomea, recording.name as nomer, recording.id, recording.length, row_number() over (order by recording.length desc) as riga
    from
        (select artist.id, artist.gender, artist.name 
        from artist_credit
            right join artist_credit_name on artist_credit.id = artist_credit_name.artist
            left join artist on artist.id = artist_credit_name.artist
            left join gender on artist.gender = gender.id 
        where artist.gender is not null and artist.gender = 2
         ) as artisti_femmina
            left join recording on artisti_femmina.id = recording.artist_credit
    where recording.length is not null
     ) as artisti_femmina_lunghezze
where riga = 1
/**/

/*Una query che avevo fatto prima di accorgermi che non si poteva usare limit
select distinct a.name, r.name, r.length
from artist a, gender g, artist_credit_name acn, artist_credit ac, 
recording r
where a.gender = g.id and a.gender = 2
and acn.artist = a.id and acn.artist_credit = r.artist_credit 
and r.length is not null
order by r.length desc
limit 1*/

/*Query 10:
Elencare le lingue cui non corrisponde nessuna release (il risultato deve contenere il nome
della lingua, il numero di release in quella lingua, cioè 0, e essere ordinato per lingua)
(scrivere due versioni della query).*/

select lingue_senza_release.id, lingue_senza_release.name, count(release.id) as qrelease
from
    (select l.id, l.name
    from language l 
    where l.id not in 
        (select distinct release.language 
         from release 
         where language is not null
        )
    )as lingue_senza_release
    left join release on release.language = lingue_senza_release.id
group by lingue_senza_release.id, lingue_senza_release.name
order by lingue_senza_release.name asc
/*
1.Informazioni presenti in release e language
2.Mi sono assicurato che non ci fossero release con linguaggi nulli nella query più interna
3.Bisognava non prendere in considerazione le release che avessero linguaggio non nullo e
selezionare solo le lingue:
select distinct release.language 
from release 
where language is not null
Da tutte le lingue leviamo queste:
select l.id, l.name
from language l 
where l.id not in 
    (select distinct release.language 
     from release 
     where language is not null
     )
e poi contare le release
4.
5.Query riportata successivamente
6.Ho eseguito la query e controllato che i valori in qrelease fossero in tutte le tuple 0 
*/

select distinct language.id, language.name, count(r2.id) as qrelease
from language
left join release r1 on r1.language = language.id
left join release r2 on language.id = r2.language
where r1.id is null and language.id is not null
group by language.id, language.name
/**/

/*Query 11:
Ricavare la seconda registrazione per lunghezza di un artista uomo (il risultato deve
comprendere l'artista accreditato, il nome della registrazione e la sua lunghezza) (scrivere
due versioni della query).*/
/*select distinct a.name, r.name, r.length
from artist a, gender g, artist_credit_name acn, artist_credit ac, 
recording r
where a.gender = g.id and a.gender = 1
and acn.artist = a.id and acn.artist_credit = r.artist_credit 
and r.length is not null
order by r.length desc
limit 1 offset 1*/

select distinct artist.name, artisti_lunghezze.name, artisti_lunghezze.length 
from(
    select distinct *, row_number() over (order by length desc) riga
    from(
        select distinct artist_credit.id artist from artist_credit_name
        full join artist on artist.id = artist_credit_name.artist
        full join artist_credit on artist_credit.id = artist_credit_name.artist
        full join gender on artist.gender = gender.id
        where gender.id = 1
        ) as artisti
    left join recording on recording.artist_credit = artisti.artist
    where length is not null
    ) as artisti_lunghezze
full join artist on artisti_lunghezze.artist = artist.id
where artisti_lunghezze.riga = 2
/*
1.Informazioni presenti in artist, artist_credit, artist_credit_name, recording e gender
2.Le condizioni di join tra artist e artist_credit, tra artist_credit_name e artist_credit, 
tra artist_credit e recording, e tra artist e artist_credit.
3.Trovare tutte le informazioni riguardanti gli artisti maschi e tenere solo in
consiederazione gli id:
select distinct artist_credit.id artist 
from artist_credit_name
        full join artist on artist.id = artist_credit_name.artist
        full join artist_credit on artist_credit.id = artist_credit_name.artist
        full join gender on artist.gender = gender.id
where gender.id = 1
Ottenere le informazioni riguardanti le registrazioni e numerare le righe che ho fatto con la
row_number():
select distinct *, row_number() over (order by length desc) riga
    from(
        select distinct artist_credit.id artist from artist_credit_name
        full join artist on artist.id = artist_credit_name.artist
        full join artist_credit on artist_credit.id = artist_credit_name.artist
        full join gender on artist.gender = gender.id
        where gender.id = 1
        ) as artisti
left join recording on recording.artist_credit = artisti.artist
where length is not null
Infine scegliere il 2° in ordine decrescente:
select distinct artist.name, artisti_lunghezze.name, artisti_lunghezze.length 
from(
    select distinct *, row_number() over (order by length desc) riga
    from(
        select distinct artist_credit.id artist from artist_credit_name
        full join artist on artist.id = artist_credit_name.artist
        full join artist_credit on artist_credit.id = artist_credit_name.artist
        full join gender on artist.gender = gender.id
        where gender.id = 1
        ) as artisti
    left join recording on recording.artist_credit = artisti.artist
    where length is not null
    ) as artisti_lunghezze
full join artist on artisti_lunghezze.artist = artist.id
where artisti_lunghezze.riga = 2
4.
5.Riportata di seguito
6.Attraverso la query:
select distinct artist.name, artisti_lunghezze.name, artisti_lunghezze.length 
from(
    select distinct *, row_number() over (order by length desc) riga
    from(
        select distinct artist_credit.id artist from artist_credit_name
        full join artist on artist.id = artist_credit_name.artist
        full join artist_credit on artist_credit.id = artist_credit_name.artist
        full join gender on artist.gender = gender.id
        where gender.id = 1
        ) as artisti
    left join recording on recording.artist_credit = artisti.artist
    where length is not null
    ) as artisti_lunghezze
full join artist on artisti_lunghezze.artist = artist.id
where length is not null
order by length desc
e vedendo che alla seconda riga ci fosse la stessa tupla della query finale
*/

select name, nomer, lunghezza
from
    (select artisti_lunghezze.name, artisti_lunghezze.artist_credit, artisti_lunghezze.gender, artisti_lunghezze.lunghezza, artisti_lunghezze.nomeR, row_number() over (order by lunghezza desc) as numero_riga
    from
        (select artisti_generi.name, artisti_generi.artist_credit, artisti_generi.gender, recording.length as lunghezza, recording.name as nomeR
        from
            (select artisti.name, artisti.artist_credit, artisti.gender 
            from
                (select artist_credit_name.name, artist_credit_name.artist_credit, artist.gender 
                from artist_credit_name
                    left join artist on artist_credit_name.artist = artist.id
                    left join artist_credit on artist_credit_name.artist = artist_credit.id
                ) as artisti
                    left join gender on gender.id = artisti.gender
                where gender = 1
            )as artisti_generi
                left join recording on artisti_generi.artist_credit = recording.artist_credit
        where recording.length is not null
        order by recording.length desc) as artisti_lunghezze
    ) as artisti_numerati
where artisti_numerati.numero_riga = 2
/**/


/*Query 12:
Per ogni stato esistente riportare la lunghezza totale delle registrazioni di artisti di quello
stato (il risultato deve comprendere il nome dello stato e la lunghezza totale in minuti delle
registrazioni (0 se lo stato non ha registrazioni) (scrivere due versioni della query).*/
/*select distinct at.id, at.name, r.id, r.name, a.name, r.length
from recording r, artist_credit ac, area a, artist at
where r.artist_credit = ac.id and ac.id = at.id and a.type = 1 
    and at.area = a.id and r.length is not null
group by at.id, r.id, at.name, a.name
order by at.id desc*/

select distinct a.name as nomearea, coalesce(sum(r.length), 0) as registrazioni
from recording r, artist_credit ac, area a, artist at, artist_credit_name acn
where r.artist_credit = ac.id and ac.id = acn.artist_credit and a.type = 1 and acn.artist = at.id
and at.area = a.id
group by nomearea
order by registrazioni desc
/*
1.Informazioni presenti in recording, artist_credit, area, artist e artist_credit_name
2.Questi vincoli d' integrità referenziale: r.artist_credit = ac.id and ac.id = acn.artist_credit
and acn.artist = at.id and at.area = a.id e che si trattasse di stati quindi a.type = 1
3.Ottenere tutte le informazioni riguardanti gli artisti, le registrazioni e gli stati e
trovare la funzione che sommasse le lunghezze con sum e quella che trasformasse i null in 0, cioè
coalesce
4.
5.Riportata di seguito
6.Eseguendola e attraverso la seconda versione della query 
*/

select distinct ar.name as nomearea, coalesce(sum(r.length), 0) as registrazioni
from recording r
	left join artist_credit_name acn on acn.artist_credit = r.artist_credit
    	left join artist a on a.id = acn.artist
    		left join area ar on a.area = ar.id
where ar.type = 1 and ar.name is not null
group by nomearea
order by registrazioni desc


/*Query 13:
Ricavare gli artisti britannici che hanno pubblicato almeno 10 release (il risultato deve
contenere il nome dell’artista, il nome dello stato (cioè United Kingdom) e il numero di
release) (scrivere due versioni della query).*/

select distinct artistname, stato, quantitàrelease
from
    (select distinct artist.name as artistname, area.name as stato, artist.id as artistid, count(r.id) as quantitàrelease
    from release r
        left join artist on artist.id = r.artist_credit
        left join area on artist.area = area.id
    where area.id is not null and lower(area.name) = 'united kingdom'
    group by artist.id, area.name
     ) as artisti
where quantitàrelease >= 10
order by quantitàrelease
/*
1.Informazioni presenti in release, artist, artist_credit e area
2.Le condizioni di join artist.id = r.artist_credit e artist.area = area.id, che area.id non
fosse null e che ci riferissimo ad artisti del regno unito con lower(area.name) = 'united
kingdom'
3.Incastrare le informazioni delle tabelle contenenti artisti e aree, selezionare solo gli
artisti del regno unito:
select distinct artist.name as artistname, area.name as stato, artist.id as artistid, count(r.id) as quantitàrelease
    from release r
        left join artist on artist.id = r.artist_credit
        left join area on artist.area = area.id
    where area.id is not null and lower(area.name) = 'united kingdom'
    group by artist.id, area.name
Successivamente che le release di questi artisti fossero maggiori a 10 e ordinare le tuple per
quantitàrelease:
select distinct artistname, stato, quantitàrelease
from
    (select distinct artist.name as artistname, area.name as stato, artist.id as artistid, count(r.id) as quantitàrelease
    from release r
        left join artist on artist.id = r.artist_credit
        left join area on artist.area = area.id
    where area.id is not null and lower(area.name) = 'united kingdom'
    group by artist.id, area.name
     ) as artisti
where quantitàrelease >= 10
order by quantitàrelease
4.L'area non deve essere null
5.Di seguito
6.Attraverso l' esecuzione di questa query:
select distinct artistname, stato, quantitàrelease
from
    (select distinct artist.name as artistname, area.name as stato, artist.id as artistid, count(r.id) as quantitàrelease
    from release r
        left join artist on artist.id = r.artist_credit
        left join area on artist.area = area.id
    where area.id is not null and lower(area.name) = 'united kingdom'
    group by artist.id, area.name
     ) as artisti
order by quantitàrelease desc
*/
select *
from
(select distinct artist.name as artistname, area.name as stato, count(r.id) as qrelease
from release r, artist, area
where area.id is not null and lower(area.name) = 'united kingdom' 
and artist.area = area.id and artist.id = r.artist_credit
group by artist.id, area.name) as inglesi
where inglesi.qrelease >= 10
order by qrelease asc


/*Query 14:
Considerando il numero medio di tracce tra le release pubblicate su CD, ricavare gli artisti
che hanno pubblicato esclusivamente release con più tracce della media (il risultato deve
contenere il nome dell’artista e il numero di release ed essere ordinato per numero di release
discendente) (scrivere due versioni della query).*/

select distinct name, qtracce
from
    (select ac.name as artist, r.id as release, r.name, count(t.id) as qtracce 
    from medium m, medium_format mf, track t, release r, artist_credit ac
    where mf.id = m.format and mf.id = 1 and t.medium = m.id 
    and r.id = m.release and ac.id = r.artist_credit
    group by ac.name, r.id
    ) as tutti
where qtracce >
    (select avg(tutti_valori.valori) as media
    from
        (select avg(tutti.qtracce) as valori --sottoquery basata su r.id(release hanno diversi id ma si chiamano uguali) e r.name
        from
            (select r.id as a, r.name as b, count(t.id) as qtracce 
            from medium m, medium_format mf, track t, release r, artist_credit ac
            where mf.id = m.format and mf.id = 1 and t.medium = m.id 
            and r.id = m.release and ac.id = r.artist_credit
            group by r.id
            order by qtracce desc
            ) as tutti
        group by tutti.a, tutti.b, tutti.qtracce
        order by qtracce desc
        ) as tutti_valori
    )
order by qtracce desc
/*
1.Informazioni in medium, medium_format, track, release e artist_credit
2.Oltre le condizioni di join, che il formato della release fosse CD
3.Contare le tracce basandomi sull'id per ogni release e fondere le tabelle medium,
medium_format, track, release e artist_credit e ordinarle per quantità di tracce per release:
select r.id as a, r.name as b, count(t.id) as qtracce 
from medium m, medium_format mf, track t, release r, artist_credit ac
where mf.id = m.format and mf.id = 1 and t.medium = m.id 
and r.id = m.release and ac.id = r.artist_credit
group by r.id
order by qtracce desc
Isolare solo i valori di quantità di tracce per release:
select avg(tutti.qtracce) as valori --sottoquery basata su r.id(release hanno diversi id ma si chiamano uguali) e r.name
	from
		(select r.id as a, r.name as b, count(t.id) as qtracce 
		from medium m, medium_format mf, track t, release r, artist_credit ac
		where mf.id = m.format and mf.id = 1 and t.medium = m.id 
		and r.id = m.release and ac.id = r.artist_credit
		group by r.id
		order by qtracce desc) as tutti
	group by tutti.a, tutti.b, tutti.qtracce
	order by qtracce desc
Fare la media di tutti questi valori trovati:
select avg(tutti_valori.valori) as media
from
	(select avg(tutti.qtracce) as valori --sottoquery basata su r.id(release hanno diversi id ma si chiamano uguali) e r.name
	from
		(select r.id as a, r.name as b, count(t.id) as qtracce 
		from medium m, medium_format mf, track t, release r, artist_credit ac
		where mf.id = m.format and mf.id = 1 and t.medium = m.id 
		and r.id = m.release and ac.id = r.artist_credit
		group by r.id
		order by qtracce desc) as tutti
	group by tutti.a, tutti.b, tutti.qtracce
	order by qtracce desc
	) as tutti_valori
Tra tutti si scelgono solo le tuple che hanno valori maggiori a questa media trovata:
select distinct name, qtracce
from
    (select ac.name as artist, r.id as release, r.name, count(t.id) as qtracce 
    from medium m, medium_format mf, track t, release r, artist_credit ac
    where mf.id = m.format and mf.id = 1 and t.medium = m.id 
    and r.id = m.release and ac.id = r.artist_credit
    group by ac.name, r.id
    ) as tutti
where qtracce >
    (select avg(tutti_valori.valori) as media
    from
        (select avg(tutti.qtracce) as valori --sottoquery basata su r.id(release hanno diversi id ma si chiamano uguali) e r.name
        from
            (select r.id as a, r.name as b, count(t.id) as qtracce 
            from medium m, medium_format mf, track t, release r, artist_credit ac
            where mf.id = m.format and mf.id = 1 and t.medium = m.id 
            and r.id = m.release and ac.id = r.artist_credit
            group by r.id
            order by qtracce desc
            ) as tutti
        group by tutti.a, tutti.b, tutti.qtracce
        order by qtracce desc
        ) as tutti_valori
    )
order by qtracce desc
4.
5.Riportata di seguito
6.Eseguendo la query finale e vedendo che le tuple su qtracce avesse tutte valori maggiori da
quelli ottenuti da questa query che ci restituisce il valore medio del campo valori:
select avg(tutti_valori.valori) as media
    from
        (select avg(tutti.qtracce) as valori --sottoquery basata su r.id(release hanno diversi id ma si chiamano uguali) e r.name
        from
            (select r.id as a, r.name as b, count(t.id) as qtracce 
            from medium m, medium_format mf, track t, release r, artist_credit ac
            where mf.id = m.format and mf.id = 1 and t.medium = m.id 
            and r.id = m.release and ac.id = r.artist_credit
            group by r.id
            order by qtracce desc
            ) as tutti
        group by tutti.a, tutti.b, tutti.qtracce
        order by qtracce desc
        ) as tutti_valori
*/
select distinct name, qtracce
from
	(select ac.name as artist, r.id as release, r.name, count(t.id) as qtracce 
	from medium m
		left join medium_format mf on mf.id = m.format
		left join track t on t.medium = m.id
		left join release r on r.id = m.release
		left join artist_credit ac on ac.id = r.artist_credit
	where mf.id = 1
	group by ac.name, r.id
	) as tutti
where qtracce >
	(select avg(tutti_valori.valori) as media
	from
		(select avg(tutti.qtracce) as valori --sottoquery basata su r.id(release hanno diversi id ma si chiamano uguali) e r.name
		from
			(select r.id as a, r.name as b, count(t.id) as qtracce 
			from medium m
				left join medium_format mf on mf.id = m.format
				left join track t on t.medium = m.id
				left join release r on r.id = m.release
				left join artist_credit ac on ac.id = r.artist_credit
			group by r.id
			order by qtracce desc) as tutti
		group by tutti.a, tutti.b, tutti.qtracce
		order by qtracce desc
		) as tutti_valori
	)
order by qtracce desc


/*Query 15:
Ricavare il primo artista morto dopo Louis Armstrong (il risultato deve contenere il nome
dell’artista, la sua data di nascita e la sua data di morte) (scrivere due versioni della query).*/

select dati_tutti.name, begin_date_day, begin_date_month, begin_date_year, end_date_day , end_date_month, end_date_year
  from
	   (select a.name, begin_date_day, begin_date_month, begin_date_year,
		a.end_date_day, a.end_date_month, a.end_date_year, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
		) as dati_tutti
where dati_tutti.riga = 1 + 
(select riga_morto_dopo_arms.riga
from
 (select dati_tutti.name, dati_tutti.edd, dati_tutti.edm, dati_tutti.edy, dati_tutti.riga
  from
	   (select a.name, a.end_date_day edd, a.end_date_month as edm, a.end_date_year as edy, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
		) as dati_tutti
  where lower(dati_tutti.name) = 'louis armstrong'
  ) as riga_morto_dopo_arms
)
/*
1.Informazioni in artist
2.Gli attributi riguardanti i giorni di nascita e morte, i mesi di nascita e morte e gli anni di
nascita e morte.
3.Ho ordinato nel seguente ordine (anno, mese, giorno) in modo crescente per numero di riga
gli artisti e ho aumentato di 1 il numero di riga:
select a.name, a.end_date_day edd, a.end_date_month as edm, a.end_date_year as edy, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
e ho trovato quello di armstrong aumentato di 1:
select dati_tutti.name, dati_tutti.edd, dati_tutti.edm, dati_tutti.edy, dati_tutti.riga
  from
	   (select a.name, a.end_date_day edd, a.end_date_month as edm, a.end_date_year as edy, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
		) as dati_tutti
  where lower(dati_tutti.name) = 'louis armstrong'
ho isolato solo il suo numero di riga:
select riga_morto_dopo_arms.riga
from
 (select dati_tutti.name, dati_tutti.edd, dati_tutti.edm, dati_tutti.edy, dati_tutti.riga
  from
	   (select a.name, a.end_date_day edd, a.end_date_month as edm, a.end_date_year as edy, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
		) as dati_tutti
  where lower(dati_tutti.name) = 'louis armstrong'
  ) as riga_morto_dopo_arms
L'ho aumentato di 1:
1 + 
(select riga_morto_dopo_arms.riga
from
 (select dati_tutti.name, dati_tutti.edd, dati_tutti.edm, dati_tutti.edy, dati_tutti.riga
  from
	   (select a.name, a.end_date_day edd, a.end_date_month as edm, a.end_date_year as edy, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
		) as dati_tutti
  where lower(dati_tutti.name) = 'louis armstrong'
  ) as riga_morto_dopo_arms
)
e infine da tutti gli artisti estraggo la tupla associata a questo valore:
select dati_tutti.name, begin_date_day, begin_date_month, begin_date_year, end_date_day , end_date_month, end_date_year
  from
	   (select a.name, begin_date_day, begin_date_month, begin_date_year,
		a.end_date_day, a.end_date_month, a.end_date_year, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
		) as dati_tutti
where dati_tutti.riga = 1 + 
(select riga_morto_dopo_arms.riga
from
 (select dati_tutti.name, dati_tutti.edd, dati_tutti.edm, dati_tutti.edy, dati_tutti.riga
  from
	   (select a.name, a.end_date_day edd, a.end_date_month as edm, a.end_date_year as edy, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
		) as dati_tutti
  where lower(dati_tutti.name) = 'louis armstrong'
  ) as riga_morto_dopo_arms
)
4.Gli interi che indicano giorno, mese e anno di morte non devono essere nulli.
5.Riportata di seguito
6.Eseguendo questa query e controllando che il numero della riga corrispondesse a quello della
query finale per la tupla successiva (maggiore di 1) a quella di armstrong:
select a.name, a.end_date_day edd, a.end_date_month as edm, a.end_date_year as edy, row_number() over (order by end_date_year, end_date_month, end_date_day) as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		order by a.end_date_year, a.end_date_month, a.end_date_day
*/
select dati_tutti.name, begin_date_day, begin_date_month, begin_date_year, end_date_day , end_date_month, end_date_year
from
	(select name, begin_date_day, begin_date_month, begin_date_year, end_date_year, end_date_month, end_date_day,
	row_number() over(order by end_date_year, end_date_month,  end_date_day) as riga
	from artist 
	where end_date_year is not null and end_date_month is not null and end_date_day is not null
	) dati_tutti
where dati_tutti.riga - 1 = 
(select riga_morto_arms.riga
from
	(select *
	from
	   (select a.name, a.end_date_day, a.end_date_month, a.end_date_year, row_number() over (order by end_date_year, end_date_month, end_date_day) + 1 as riga  
		from artist a
		where a.type = 1 and (a.end_date_day is not null and a.end_date_month is not null 
		and a.end_date_year is not null)
		) as dati_tutti
	where lower(dati_tutti.name) = 'louis armstrong'
	) as riga_morto_arms
)


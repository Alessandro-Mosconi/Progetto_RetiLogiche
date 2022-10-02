# Progetto_RetiLogiche

Lo scopo del progetto consiste nell’implementare un componente hardware, descritto in VHDL, che riceva in ingresso una serie di parole da 8 bit, le serializzi in un flusso continuo di singoli bit i quali, una volta codificati tramite codice convoluzionale ½, vengano riuniti a formare parole da 8 bit che verranno scritte in memoria. Il primo valore letto da memoria contiene il numero di parole da codificare. Ogni parola letta verrà quindi codificata in due come scritto nel seguente schema
(uk = stream di singoli bit in ingresso, yk= bit codificati in uscita)

<img src="https://github.com/Alessandro-Mosconi/Progetto_RetiLogiche/blob/main/resources/Codificatore.png" width=75% height=75%>

## ARCHITETTURA

È stato scelto di dividere il componente hardware in datapath e macchina a stati finiti per semplificare lo sviluppo

### Datapath

<img src="https://github.com/Alessandro-Mosconi/Progetto_RetiLogiche/blob/main/resources/Datapath.png" width=75% height=75%>

All’interno del datapath sono stati progettati due componenti che realizzano i puntatori agli indirizzi delle celle di memoria da leggere e scrivere

<img src="https://github.com/Alessandro-Mosconi/Progetto_RetiLogiche/blob/main/resources/MemReg.png" width=75% height=75%>

* Contenuto di output_addr: indirizzo di 16 bit su cui scrivere la parola codificata
* Contenuto di input_addr: indirizzo di 16 bit da cui leggere la parola da codificare

### Macchina a Stati Finiti

<img src="https://github.com/Alessandro-Mosconi/Progetto_RetiLogiche/blob/main/resources/MSF.png" width=75% height=75%>

È stato utilizzato il segnale o_end per verificare se il numero di parole da codificare sia = 0. Output_addr e input_addr sono utilizzati per recuperare dal datapath i valori progressivi dei puntatori alle celle di memoria, rispettivamente, di output e di input. I segnali non specificati sono inizializzati a 0 di default

## IMPLEMENTAZIONE

Per consultare lo schema di implementazione accedere all' appostia voce all'interno del file [Progetto_RetiLogiche_descrizione](https://github.com/Alessandro-Mosconi/Progetto_RetiLogiche/blob/main/Progetto_RetiLogiche_descrizione.pdf)

## RISULTATI

### Sintesi

Il componente è correttamente sintetizzabile e implementabile con un totale di 91 LUT, 63 FF e senza la presenza di alcun Latch

<img src="https://github.com/Alessandro-Mosconi/Progetto_RetiLogiche/blob/main/resources/Results.png" width=75% height=75%>

### Simulazioni

Per verificare il corretto funzionamento del componente, oltre ad averlo testato con i diversi testbench forniti dall’insegnante, è stato utilizzato un test che, utilizzando una ram scritta su file, esegue un test con 10000 differenti casi di prova costruiti grazie ad un generatore sviluppato con linguaggio python. È stata verificata la correttezza del progetto anche nei seguenti casi limite: 
* sequenza minima (prima cella contenente il numero di parole analizzate = 0)
* test contenente più reset successivi (test che verifica il corretto funzionamento del componente nel caso in cui un processo venga interrotto da un segnale di reset e un altro venga avviato)
* sequenza massima (255 parole consecutive)
* test con più sequenze di parole da codificare in successione
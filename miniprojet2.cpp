/****---------------- MINI PROJET : COMPARAISON DE LA FFT CALCULE PAR PROGRAMME C++ ET MATLAB  --------------------****/

/*----------------------------------------------------------------------------------------------------------------------------------
####################################################################################################################################

Organisation    : SICoM - FST 
Mini projet  	: CALCULE DE LA FFT 
Nom de fichier 	: AbirMouaouya_miniprojet2.cpp
Description 	: ce programme permet de calculer la FFT 

Classes : 
        * classe complexe 
fonctions utilisées :   
        * float energie (float* TAB)
        * float puissance (float* TAB)
        * int nbrLigne()
		* Fonctions predefinies sur les directives iostream,fstream,string ,string.h 
		
Historique 		: 10/03/2021 
COPYRIGHT 		: FST-USMBA 
Crée par 		: ABIR MOUAOUYA 
Encadré par 	: HICHAM GHENNIOUI 

#####################################################################################################################################
-----------------------------------------------------------------------------------------------------------------------------------*/
 /*____________________________ les directives de  preprocesseur ________________________________________________*/
/*--------------------------------------------------------------------------------------------------------------*/

#include<locale>            // directive de  preprocesseur qui gére les extensions d'affichage accenté  
#include<iostream>         // directive de  preprocesseur qui gére les extensions des entrées/sorties 
#include<fstream>	   	  // directive de preprocesseur chargé des extensions de manipulation des fichiers 
#include<math.h>
const float pi=3.141592654; //definir la grandeure pi 

int NbrEch;    // variable globale , contient les nombres de echantillons à traiter 
using namespace std;   // espace de définition des commandes pour éviter la répitition de std 


class complexe{                 // la classe complexe prend comme attributs la partie rel et imaginaire du nombre  
	public :  //Attribut        
	  float  reel=0;           //par defaut le reel et l'imagianire sont initialiser par 0
	  float  im=0;
	  };
	  

// fonction puissance : permet de clalculer la puissance du signal donné par ses echnatilons 
float puissance (float* TAB){
	int i;
	float s=0;     //initialiser l variable de sommation 
	for(i=0;i<NbrEch;i++)   
	  s+=pow(TAB[i],2)	;  // sommer les carrés
	return s/NbrEch;     // retourner la somme diviser par le nombre des echantillons 
}

//fonction Energie : permet de clalculer l'energie d'un signal donné par ses echnatilons 
float energie (float* TAB){
	int i;
	float s=0;     //initialiser l variable de sommation 
	for(i=0;i<NbrEch;i++)   
	  s+=pow(TAB[i],2)	;  // sommer les carrés
	return s;     // retourner la somme  des echantillons 
}

// fonction nbrLigne : c'est la fontion qui calcule le nombre des echantillons dans un fichier 
int nbrLigne(){ 
    int cmp=0;
    string ligne;
	ifstream echFile ("echantillon.txt");
	 while( getline(echFile,ligne)) 
	     cmp++;
    return cmp;     
	}
	

/************************************************            FONCTION PRINCIPALE            ********************************************************/
main(){
	setlocale(LC_CTYPE, "fra"); 
	int i,j;
	complexe n;
	complexe *TabFFT;
	float  *TabE;
	//ouvrir les fichiers 
	ofstream file ("FFTcpp.txt");     // fichier FFTcpp dont on va stoker la FFT calculer 
	ifstream echFile ("echantillon.txt");// fichier d'echantillon donné par matlab 
	
	::NbrEch=nbrLigne();   // :: pour acceder à la variable globale , le nbr de lignes du fichier echantilon.txt est le nombre des echantillons à traiter 
	
	TabE= new float [NbrEch];         // tableau ou on va charger les echantillons 
	TabFFT= new complexe[NbrEch];    //tableur ou va stocker la FFT 	
	
	for(i=0;i<NbrEch;i++)   //charger le tableau par les echantillons
	    echFile>>TabE[i];
	    
	for(i=0;i<NbrEch;i++){ // calcul de la FFT 
		n.im=0;
		n.reel=0;
	    for(j=0;j<NbrEch;j++){
		    n.reel += TabE[j]*cos(2*pi*j*i/NbrEch);
		    n.im  += TabE[j]*sin(2*pi*j*i/NbrEch);
			}
	   TabFFT[i].reel=n.reel;   //charger le tableau par la FFT 
	   TabFFT[i].im=n.im;
	   	}
	   	
    
  for(i=0;i<NbrEch;i++)   // charger la fft dans le fichier 
	    file <<TabFFT[i].reel<<"\t"<<TabFFT[i].im<<endl;
		
/***********************************   AFFICHER Les infos du signal donné par ses échantillons *************************************/	
cout<<" Bienvenue dans notre interface de calcul de la FFT en C++"<<endl<<endl;
cout<<" suite à nos traitements , on constate que :"<<endl;
cout<<"        * le nombre des echantillons données : "<<NbrEch<<endl;
cout<<"        * la puissance du signal  : "<<puissance(TabE)<<endl;
cout<<"        * l'energie du signal     : "<<energie(TabE)<<endl;
}

/******************************************************   END ************************************************************************/		

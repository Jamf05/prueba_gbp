import 'package:flutter/material.dart';
import 'package:prueba_gbp/app/context/settings/app_settings.dart';
import 'package:prueba_gbp/app/context/settings/application_colors.dart';

/*
 
  ######     ##        #######     ###    ########  #### ##    ##  ######   
 ##    ##    ##       ##     ##   ## ##   ##     ##  ##  ###   ## ##    ##  
 ##          ##       ##     ##  ##   ##  ##     ##  ##  ####  ## ##        
 ##          ##       ##     ## ##     ## ##     ##  ##  ## ## ## ##   #### 
 ##          ##       ##     ## ######### ##     ##  ##  ##  #### ##    ##  
 ##    ##    ##       ##     ## ##     ## ##     ##  ##  ##   ### ##    ##  
  ######     ########  #######  ##     ## ########  #### ##    ##  ######   
 
*/

Widget splashScreenWdiget() {
  return Container(
    alignment: Alignment.center,
    child: Icon(Icons.movie, size: 200, color: ApplicationColors().white.withOpacity(0.5),)
  );
}

/*
 
  ######     ########  ##     ## ######## ########  #######  ##    ## 
 ##    ##    ##     ## ##     ##    ##       ##    ##     ## ###   ## 
 ##          ##     ## ##     ##    ##       ##    ##     ## ####  ## 
 ##          ########  ##     ##    ##       ##    ##     ## ## ## ## 
 ##          ##     ## ##     ##    ##       ##    ##     ## ##  #### 
 ##    ##    ##     ## ##     ##    ##       ##    ##     ## ##   ### 
  ######     ########   #######     ##       ##     #######  ##    ## 

  Document   : static_widget
  Created on : 06/08/2020 06:17 PM
  Author     : Jorge Mogotocoro

  parameters :  size        ->
                text        -> Texto que se va mostrar en el boton
                onPressed   -> Accion a realizar

  description:  Crea un boton con estilo personalizado para reutilizarlo.

  @Last modification:  
  @Author: 

*/

Widget customButton({
  @required Size size,
  @required String text,
  @required Function onPressed
}){
  return ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Container(
        width: 140,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ApplicationColors().gray,
            borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          text,
          style: AppSettings().homeSubTitleStyle
        ),
      ),
      onPressed: onPressed,
    ),
  );
}
package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import flash.geom.Rectangle;
   
   public class FormattedTextController extends TextController
   {
      
      public function FormattedTextController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function set text(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_localized)
         {
            context.removeLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            _localized = false;
         }
         _caption = param1;
         if(!var_1067 && _caption.charAt(0) == "$" && _caption.charAt(1) == "{")
         {
            _localized = true;
            context.registerLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
         }
         else if(_field != null)
         {
            _field.htmlText = _caption;
            refreshTextImage();
         }
      }
      
      override public function set localization(param1:String) : void
      {
         if(param1 != null && _field != null)
         {
            _field.htmlText = limitStringLength(param1);
            refreshTextImage();
         }
      }
   }
}


package com.sulake.habbo.utils
{
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   
   public class InfoText
   {
      
      private var var_158:ITextFieldWindow;
      
      private var _includeInfo:Boolean;
      
      private var var_2864:String = "";
      
      public function InfoText(param1:ITextFieldWindow, param2:String = null)
      {
         super();
         var_158 = param1;
         if(param2 != null)
         {
            _includeInfo = true;
            var_2864 = param2;
            var_158.text = param2;
         }
         var_158.addEventListener("WE_FOCUSED",onFocus);
      }
      
      public function dispose() : void
      {
         if(var_158)
         {
            var_158.dispose();
            var_158 = null;
         }
      }
      
      public function goBackToInitialState() : void
      {
         var_158.text = var_2864;
         _includeInfo = true;
      }
      
      public function getText() : String
      {
         return _includeInfo ? "" : var_158.text;
      }
      
      public function setText(param1:String) : void
      {
         _includeInfo = false;
         var_158.text = param1;
      }
      
      public function get input() : ITextFieldWindow
      {
         return var_158;
      }
      
      private function onFocus(param1:class_1758) : void
      {
         if(!_includeInfo)
         {
            return;
         }
         var_158.text = "";
         _includeInfo = false;
      }
   }
}


package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
   
   public class TextInputCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var var_2600:ITextFieldWindow;
      
      public function TextInputCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_2600 = _window.findChildByName("input_text") as ITextFieldWindow;
         if(var_2600 != null)
         {
            var_2600.addEventListener("WKE_KEY_UP",onKey);
         }
         return true;
      }
      
      private function onKey(param1:WindowKeyboardEvent) : void
      {
         if(var_2600 == null)
         {
            return;
         }
         events.dispatchEvent(new TextInputEvent(var_2600.text));
      }
   }
}


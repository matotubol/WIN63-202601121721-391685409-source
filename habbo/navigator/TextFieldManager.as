package com.sulake.habbo.navigator
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Point;
   
   public class TextFieldManager
   {
      
      private var _navigator:class_42;
      
      private var var_158:ITextFieldWindow;
      
      private var _includeInfo:Boolean;
      
      private var var_2864:String = "";
      
      private var _maxTextLen:int;
      
      private var var_3578:Function;
      
      private var var_5253:String = "";
      
      private var _errorPopup:class_1812;
      
      private var var_5275:Boolean;
      
      private var _orgTextBackgroundColor:uint;
      
      public function TextFieldManager(param1:class_42, param2:ITextFieldWindow, param3:int = 1000, param4:Function = null, param5:String = null)
      {
         super();
         _navigator = param1;
         var_158 = param2;
         _maxTextLen = param3;
         param2.maxChars = param3;
         var_3578 = param4;
         if(param5 != null)
         {
            _includeInfo = true;
            var_2864 = param5;
            var_158.text = param5;
         }
         Util.setProcDirectly(var_158,onInputClick);
         var_158.addEventListener("WKE_KEY_DOWN",checkEnterPress);
         var_158.addEventListener("WE_CHANGE",checkMaxLen);
         this.var_5275 = var_158.textBackground;
         this._orgTextBackgroundColor = var_158.textBackgroundColor;
      }
      
      public function dispose() : void
      {
         if(var_158)
         {
            var_158.dispose();
            var_158 = null;
         }
         if(_errorPopup)
         {
            _errorPopup.dispose();
            _errorPopup = null;
         }
         _navigator = null;
      }
      
      public function checkMandatory(param1:String) : Boolean
      {
         if(!isInputValid())
         {
            displayError(param1);
            return false;
         }
         restoreBackground();
         return true;
      }
      
      public function restoreBackground() : void
      {
         var_158.textBackground = this.var_5275;
         var_158.textBackgroundColor = this._orgTextBackgroundColor;
      }
      
      public function displayError(param1:String) : void
      {
         var_158.textBackground = true;
         var_158.textBackgroundColor = 4294021019;
         if(this._errorPopup == null)
         {
            this._errorPopup = class_1812(_navigator.getXmlWindow("nav_error_popup"));
            _navigator.refreshButton(this._errorPopup,"popup_arrow_down",true,null,0);
            class_1812(var_158.parent).addChild(this._errorPopup);
         }
         var _loc4_:ITextWindow = ITextWindow(this._errorPopup.findChildByName("error_text"));
         _loc4_.text = param1;
         _loc4_.width = _loc4_.textWidth + 5;
         _errorPopup.findChildByName("border").width = _loc4_.width + 15;
         _errorPopup.width = _loc4_.width + 15;
         var _loc2_:Point = new Point();
         var_158.getLocalPosition(_loc2_);
         this._errorPopup.x = _loc2_.x;
         this._errorPopup.y = _loc2_.y - this._errorPopup.height + 3;
         var _loc3_:class_1741 = _errorPopup.findChildByName("popup_arrow_down");
         _loc3_.x = this._errorPopup.width / 2 - _loc3_.width / 2;
         _errorPopup.x += (var_158.width - _errorPopup.width) / 2;
         this._errorPopup.visible = true;
      }
      
      public function goBackToInitialState() : void
      {
         clearErrors();
         if(var_2864 != null)
         {
            var_158.text = var_2864;
            _includeInfo = true;
         }
         else
         {
            var_158.text = "";
            _includeInfo = false;
         }
      }
      
      public function getText() : String
      {
         if(_includeInfo)
         {
            return var_5253;
         }
         return var_158.text;
      }
      
      public function setText(param1:String) : void
      {
         _includeInfo = false;
         var_158.text = param1;
      }
      
      public function clearErrors() : void
      {
         this.restoreBackground();
         if(this._errorPopup != null)
         {
            _errorPopup.visible = false;
         }
      }
      
      public function get input() : ITextFieldWindow
      {
         return var_158;
      }
      
      private function isInputValid() : Boolean
      {
         return !_includeInfo && Util.trim(getText()).length > 2;
      }
      
      private function onInputClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(!_includeInfo)
         {
            return;
         }
         var_158.text = var_5253;
         _includeInfo = false;
         this.restoreBackground();
      }
      
      private function checkEnterPress(param1:WindowKeyboardEvent) : void
      {
         if(param1.charCode == 13)
         {
            if(var_3578 != null)
            {
               var_3578();
            }
         }
      }
      
      private function checkMaxLen(param1:class_1758) : void
      {
         var _loc2_:String = var_158.text;
         if(_loc2_.length > _maxTextLen)
         {
            var_158.text = _loc2_.substring(0,_maxTextLen);
         }
      }
   }
}


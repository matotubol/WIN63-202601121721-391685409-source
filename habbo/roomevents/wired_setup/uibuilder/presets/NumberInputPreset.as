package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NumberInputPreset extends WiredUIPreset
   {
      
      private var var_1102:class_1741;
      
      private var var_76:ITextFieldWindow;
      
      private var var_44:NumberInputParam;
      
      private var var_2927:int;
      
      private var var_2870:int;
      
      private var var_532:String;
      
      private var _min:int;
      
      private var var_1935:int;
      
      private var var_1641:int;
      
      private var var_2085:Boolean;
      
      private var var_1914:int;
      
      private var var_3765:Function;
      
      private var _ignoreListeners:Boolean = false;
      
      public function NumberInputPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:NumberInputParam)
      {
         super(param1,param2,param3);
         var_1102 = param3.createTextInputView();
         var_76 = var_1102.findChildByName("field") as ITextFieldWindow;
         var_44 = param4;
         var_1914 = var_1102.width - var_76.width;
         if(param4.width >= 0)
         {
            var_1102.width = param4.width + var_1914;
         }
         var_76.restrict = "0123456789" + (param4.min < 0 ? "\\-" : "") + (param4.precision > 0 ? ",." : "") + (param4.nonDecimalNotations ? "xba-fA-F" : "");
         var_2085 = param4.endsWithFive;
         _min = var_2085 ? param4.min * 5 : param4.min;
         var_1935 = var_2085 ? param4.max * 5 : param4.max;
         var_1641 = param4.precision;
         setValue(param4.initialValue);
         var_76.addEventListener("WE_CHANGE",onTextChange);
      }
      
      private static function swapChars(param1:String, param2:int, param3:int) : String
      {
         var _loc5_:Array = param1.split("");
         var _loc4_:String = _loc5_[param2];
         _loc5_[param2] = _loc5_[param3];
         _loc5_[param3] = _loc4_;
         return _loc5_.join("");
      }
      
      private static function isValidInt(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^-?\d+$/;
         return _loc2_.test(param1);
      }
      
      public function set onValueChange(param1:Function) : void
      {
         var_3765 = param1;
      }
      
      private function displayValue(param1:int) : String
      {
         var _loc2_:String = param1.toString();
         if(var_1641 > 0)
         {
            while(_loc2_.length < var_1641 + 1)
            {
               _loc2_ = "0" + _loc2_;
            }
            _loc2_ = _loc2_.substring(0,_loc2_.length - var_1641) + "." + _loc2_.substring(_loc2_.length - var_1641);
            while(_loc2_.charAt(_loc2_.length - 1) == "0")
            {
               _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
            }
            if(_loc2_.charAt(_loc2_.length - 1) == ".")
            {
               _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
            }
         }
         return _loc2_;
      }
      
      private function setValue(param1:int) : void
      {
         _ignoreListeners = true;
         var_2927 = param1;
         var_2870 = param1;
         var_532 = displayValue(var_2085 ? param1 * 5 : param1);
         var_76.text = var_532;
         _ignoreListeners = false;
      }
      
      public function set value(param1:int) : void
      {
         setValue(param1);
      }
      
      public function reset() : void
      {
         setValue(var_44.initialValue);
      }
      
      private function onTextChange(param1:class_1758) : void
      {
         var _loc2_:int = 0;
         if(_ignoreListeners)
         {
            return;
         }
         var _loc7_:String = var_76.text;
         if(_loc7_ == "" || _loc7_ == "-" && var_44.min < 0)
         {
            return;
         }
         if(var_44.nonDecimalNotations && (_loc7_.indexOf("0b") == 0 || _loc7_.indexOf("0x") == 0))
         {
            _loc2_ = _loc7_.indexOf("0b") == 0 ? parseInt(_loc7_.substr(2),2) : parseInt(_loc7_.substr(2),16);
            setValidValueAndNotify(_loc2_ < _min ? _min : (_loc2_ > var_1935 ? var_1935 : _loc2_));
            return;
         }
         var _loc8_:String = _loc7_.replace(",",".");
         if(var_1641 > 0)
         {
            if(_loc8_.charAt(_loc8_.length - 1) == ".")
            {
               _loc8_ = _loc8_.substring(0,_loc8_.length - 1);
            }
            var _loc3_:RegExp = /^-?([0-9]*[.])?[0-9]+$/;
            if(!null.test(_loc8_))
            {
               _ignoreListeners = true;
               var_76.text = var_532;
               _ignoreListeners = false;
               return;
            }
            var _loc4_:int = 0;
            while(0 < var_1641)
            {
               var _loc5_:int = int(_loc8_.indexOf("."));
               if(_loc5_ == -1)
               {
                  _loc8_ += "0";
               }
               else
               {
                  _loc8_ = swapChars(_loc8_,0,0 + 1);
                  if(_loc8_.charAt(_loc8_.length - 1) == ".")
                  {
                     _loc8_ = _loc8_.substring(0,_loc8_.length - 1);
                  }
               }
               _loc4_++;
            }
         }
         var _loc6_:ITextFieldWindow = var_76;
         if(var_2085 && _loc8_.charAt(_loc8_.length - 1) != "0" && _loc8_.charAt(_loc8_.length - 1) != "5")
         {
            _loc6_.text = var_532;
            return;
         }
         _loc2_ = int(_loc8_);
         if(!isNaN(_loc2_) && isValidInt(_loc8_))
         {
            if(String(_loc2_).length <= String(var_44.min).length && _loc2_ < var_44.min && String(var_44.max).length > String(var_44.min).length)
            {
               return;
            }
            if(_loc2_ >= _min && _loc2_ <= var_1935)
            {
               var_532 = _loc6_.text;
            }
            else if(_loc2_ < _min)
            {
               _loc2_ = _min;
               var_532 = displayValue(_min);
               _loc6_.text = var_532;
            }
            else
            {
               _loc2_ = var_1935;
               var_532 = displayValue(var_1935);
               _loc6_.text = var_532;
            }
            setValidValueAndNotify(var_2085 ? _loc2_ / 5 : _loc2_);
         }
         else
         {
            _loc6_.text = var_532;
         }
      }
      
      private function setValidValueAndNotify(param1:int) : void
      {
         var_2870 = param1;
         if(var_3765 != null)
         {
            var_3765(param1);
         }
      }
      
      public function get value() : int
      {
         return var_2870;
      }
      
      public function get number() : Number
      {
         return Number(var_532);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return var_44.width >= 0;
      }
      
      override public function get staticWidth() : int
      {
         if(var_44.width >= 0)
         {
            return var_44.width + var_1914;
         }
         throw new Exception("Number input with -1 width has no static width");
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var _loc2_:int = int(var_44.width >= 0 ? var_44.width + var_1914 : param1);
         var_1102.width = _loc2_;
      }
      
      override public function get window() : class_1741
      {
         return var_1102;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_1102.dispose();
         var_1102 = null;
         var_44 = null;
      }
   }
}


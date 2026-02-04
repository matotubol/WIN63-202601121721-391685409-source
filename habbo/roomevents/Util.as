package com.sulake.habbo.roomevents
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.utils.class_1897;
   import package_189.WiredVariable;
   import package_189.class_4013;
   
   public class Util
   {
      
      public static const VARIABLE_SYNTAX_MODE_PRETTIFY:int = 0;
      
      public static const VARIABLE_SYNTAX_MODE_NONE:int = 1;
      
      public function Util()
      {
         super();
      }
      
      public static function setProcDirectly(param1:class_1741, param2:Function) : void
      {
         param1.setParamFlag(1,true);
         param1.procedure = param2;
      }
      
      public static function getLowestPoint(param1:class_1812) : int
      {
         var _loc2_:int = 0;
         var _loc4_:class_1741 = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible && _loc4_.height > 0)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function hideChildren(param1:class_1812, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1741 = null;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(!(param2 && _loc4_.name == "ruler"))
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
      }
      
      public static function showChildren(param1:class_1812) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = true;
            _loc2_++;
         }
      }
      
      public static function moveChildrenToColumn(param1:class_1812, param2:Array, param3:int, param4:int) : void
      {
         var _loc6_:class_1741 = null;
         for each(var _loc5_ in param2)
         {
            _loc6_ = param1.getChildByName(_loc5_);
            if(_loc6_ != null && _loc6_.visible && _loc6_.height > 0)
            {
               _loc6_.y = param3;
               param3 += _loc6_.height + param4;
            }
         }
      }
      
      public static function moveAllChildrenToColumn(param1:class_1812, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:class_1741 = null;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_);
            if(_loc5_ != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public static function select(param1:class_1885, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      public static function flatVariableName(param1:WiredVariable) : String
      {
         return param1.variableName.replace("@","").replace("~","").replace(/\./g,"_");
      }
      
      public static function splitName(param1:WiredVariable) : Array
      {
         var _loc3_:Array = param1.variableName.split(".");
         var _loc2_:Array = [];
         for each(var _loc4_ in _loc3_)
         {
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function variableValueWithString(param1:WiredVariable, param2:int) : String
      {
         if(!param1.hasValue)
         {
            return null;
         }
         var _loc4_:Boolean = param2 == 2147483647 || param2 == -2147483648;
         if(_loc4_)
         {
            return "Hidden";
         }
         var _loc3_:String = getConnectedText(param1,param2);
         return String(param2) + (_loc3_ == null ? "" : " (" + _loc3_ + ")");
      }
      
      public static function getConnectedText(param1:WiredVariable, param2:int) : String
      {
         var _loc3_:class_55 = param1.textConnector;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getValue(param2);
      }
      
      public static function getIntFromInput(param1:ITextFieldWindow, param2:int, param3:Boolean = false) : int
      {
         return getIntFromString(param1.text,param2,param3);
      }
      
      public static function getIntFromString(param1:String, param2:int, param3:Boolean = false) : int
      {
         if(param3 && param1.indexOf("0b") == 0)
         {
            return parseInt(param1.substr(2),2);
         }
         if(param3 && param1.indexOf("0x") == 0)
         {
            return parseInt(param1.substr(2),16);
         }
         if(isNaN(Number(param1)))
         {
            return param2;
         }
         return int(param1);
      }
      
      public static function pushIntAsLong(param1:Array, param2:int) : void
      {
         param1.push(param2 < 0 ? -1 : 0);
         param1.push(param2);
      }
      
      public static function disableSection(param1:class_1741, param2:Boolean = true) : void
      {
         var _loc3_:class_1812 = null;
         var _loc4_:int = 0;
         if(param1.tags.indexOf("DO_NOT_DISABLE") != -1)
         {
            return;
         }
         var _loc5_:Number = param2 ? 0.5 : 1;
         if(param1.tags.indexOf("HALF_BLEND") != -1)
         {
            _loc5_ /= 2;
         }
         if(!(param1 is class_1775))
         {
            if(param1 is class_1812 || param1 is IItemListWindow || param1 is ISelectorWindow)
            {
               if(param1 is class_1897)
               {
                  for each(var _loc6_ in (param1 as class_1897).children)
                  {
                     disableSection(_loc6_,param2);
                  }
               }
               else if(param1 is class_1812)
               {
                  _loc3_ = param1 as class_1812;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.numChildren)
                  {
                     disableSection(_loc3_.getChildAt(_loc4_),param2);
                     _loc4_++;
                  }
               }
               if(param1 is class_1993)
               {
                  param1.blend = _loc5_;
               }
            }
            else
            {
               param1.blend = _loc5_;
            }
         }
         if(param2)
         {
            param1.disable();
         }
         else
         {
            param1.enable();
         }
      }
      
      private static function variableCompare(param1:WiredVariable, param2:WiredVariable) : int
      {
         var _loc4_:* = param1.variableType == class_4013.INTERNAL;
         var _loc3_:* = param2.variableType == class_4013.INTERNAL;
         if(_loc4_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc4_)
         {
            return -1;
         }
         if(_loc4_)
         {
            if(Number(param1.variableId) > Number(param2.variableId))
            {
               return -1;
            }
            if(Number(param1.variableId) == Number(param2.variableId))
            {
               return 0;
            }
            return 1;
         }
         return param1.variableName.localeCompare(param2.variableName);
      }
      
      public static function sortVariables(param1:*) : void
      {
         param1.sort(variableCompare);
      }
      
      public static function compareIntArrays(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(param1.length != param2.length)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != param2[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function findVariableById(param1:Array, param2:String) : WiredVariable
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.variableId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function uintToHexColor(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "#" + _loc2_;
      }
   }
}


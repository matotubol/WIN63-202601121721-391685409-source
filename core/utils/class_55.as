package com.sulake.core.utils
{
   import com.sulake.core.runtime.class_13;
   import flash.utils.Dictionary;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   [SecureSWF(rename="true")]
   public class class_55 extends Proxy implements class_13
   {
      
      private var _length:uint;
      
      private var var_457:Dictionary;
      
      private var var_120:Array;
      
      private var var_397:Array;
      
      public function class_55()
      {
         super();
         _length = 0;
         var_457 = new Dictionary();
         var_120 = [];
         var_397 = [];
      }
      
      public function get length() : uint
      {
         return _length;
      }
      
      public function get disposed() : Boolean
      {
         return var_457 == null;
      }
      
      public function dispose() : void
      {
         var_457 = null;
         _length = 0;
         var_120 = null;
         var_397 = null;
      }
      
      public function reset() : void
      {
         var_457 = new Dictionary();
         _length = 0;
         var_120 = [];
         var_397 = [];
      }
      
      public function unshift(param1:*, param2:*) : Boolean
      {
         if(var_457[param1] != null)
         {
            return false;
         }
         var_457[param1] = param2;
         var_120.unshift(param2);
         var_397.unshift(param1);
         _length = _length + 1;
         return true;
      }
      
      public function add(param1:*, param2:*) : Boolean
      {
         if(var_457[param1] != null)
         {
            return false;
         }
         var_457[param1] = param2;
         var_120[_length] = param2;
         var_397[_length] = param1;
         _length = _length + 1;
         return true;
      }
      
      public function remove(param1:*) : *
      {
         var _loc2_:Object = var_457[param1];
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:int = int(var_397.indexOf(param1));
         if(_loc3_ >= 0)
         {
            var_120.splice(_loc3_,1);
            var_397.splice(_loc3_,1);
            _length = _length - 1;
         }
         delete var_457[param1];
         return _loc2_;
      }
      
      public function getWithIndex(param1:int) : *
      {
         if(param1 < 0 || param1 >= _length)
         {
            return null;
         }
         return var_120[param1];
      }
      
      public function getKey(param1:int) : *
      {
         if(param1 < 0 || param1 >= _length)
         {
            return null;
         }
         return var_397[param1];
      }
      
      public function getKeys() : Array
      {
         return var_397.slice();
      }
      
      public function hasKey(param1:*) : Boolean
      {
         return var_397.indexOf(param1) > -1;
      }
      
      public function getValue(param1:*) : *
      {
         return var_457[param1];
      }
      
      public function getValues() : Array
      {
         return var_120.slice();
      }
      
      public function hasValue(param1:*) : Boolean
      {
         return var_120.indexOf(param1) > -1;
      }
      
      public function indexOf(param1:*) : int
      {
         return var_120.indexOf(param1);
      }
      
      public function concatenate(param1:class_55) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = param1.var_397;
         for each(_loc3_ in _loc2_)
         {
            add(_loc3_,param1[_loc3_]);
         }
      }
      
      public function clone() : class_55
      {
         var _loc1_:class_55 = new class_55();
         _loc1_.concatenate(this);
         return _loc1_;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         if(param1 is QName)
         {
            param1 = QName(param1).localName;
         }
         return var_457[param1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         if(param1 is QName)
         {
            param1 = QName(param1).localName;
         }
         var_457[param1] = param2;
         var _loc3_:int = int(var_397.indexOf(param1));
         if(_loc3_ == -1)
         {
            var_120[_length] = param2;
            var_397[_length] = param1;
            _length = _length + 1;
         }
         else
         {
            var_120.splice(_loc3_,1,param2);
         }
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < _length ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextName(param1:int) : String
      {
         return var_397[param1 - 1];
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return var_120[param1 - 1];
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         return param1.localName == "toString" ? "Map" : null;
      }
   }
}


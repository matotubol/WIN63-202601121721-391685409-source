package com.sulake.core.runtime
{
   import flash.utils.getQualifiedClassName;
   
   internal final class InterfaceStruct implements class_13
   {
      
      private var var_2433:IID;
      
      private var _iis:String;
      
      private var var_83:IUnknown;
      
      private var var_1032:uint;
      
      public function InterfaceStruct(param1:IID, param2:IUnknown)
      {
         super();
         var_2433 = param1;
         _iis = getQualifiedClassName(var_2433);
         var_83 = param2;
         var_1032 = 0;
      }
      
      public function get iid() : IID
      {
         return var_2433;
      }
      
      public function get iis() : String
      {
         return _iis;
      }
      
      public function get unknown() : IUnknown
      {
         return var_83;
      }
      
      public function get references() : uint
      {
         return var_1032;
      }
      
      public function get disposed() : Boolean
      {
         return var_83 == null;
      }
      
      public function dispose() : void
      {
         var_2433 = null;
         _iis = null;
         var_83 = null;
         var_1032 = 0;
      }
      
      public function reserve() : uint
      {
         return ++var_1032;
      }
      
      public function release() : uint
      {
         return references > 0 ? --var_1032 : 0;
      }
   }
}


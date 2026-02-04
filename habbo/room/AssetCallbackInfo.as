package com.sulake.habbo.room
{
   public class AssetCallbackInfo
   {
      
      private var var_197:int;
      
      private var _listeners:Vector.<class_1829>;
      
      public function AssetCallbackInfo(param1:int)
      {
         super();
         this.var_197 = param1;
         this._listeners = new Vector.<class_1829>();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get listeners() : Vector.<class_1829>
      {
         return _listeners;
      }
   }
}


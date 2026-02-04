package com.sulake.core.window.motion
{
   import com.sulake.core.window.class_1741;
   
   use namespace friend;
   
   public class Motion
   {
      
      protected var var_202:class_1741;
      
      protected var var_983:Boolean;
      
      protected var var_270:Boolean = true;
      
      protected var var_3795:String;
      
      public function Motion(param1:class_1741)
      {
         super();
         var_202 = param1;
      }
      
      public function get running() : Boolean
      {
         return var_983 && var_202 && !var_202.disposed;
      }
      
      public function get complete() : Boolean
      {
         return var_270;
      }
      
      public function set target(param1:class_1741) : void
      {
         var_202 = param1;
      }
      
      public function get target() : class_1741
      {
         return var_202;
      }
      
      public function set tag(param1:String) : void
      {
         var_3795 = param1;
      }
      
      public function get tag() : String
      {
         return var_3795;
      }
      
      friend function start() : void
      {
         var_983 = true;
      }
      
      friend function update(param1:Number) : void
      {
      }
      
      friend function stop() : void
      {
         var_202 = null;
         var_983 = false;
      }
      
      friend function tick(param1:int) : void
      {
      }
   }
}


package com.sulake.habbo.freeflowchat.history.visualization.entry
{
   import flash.display.Bitmap;
   
   public class class_2441 extends Bitmap
   {
      
      private var var_1270:int;
      
      private var var_1951:int;
      
      private var var_4037:Boolean;
      
      private var _userName:String;
      
      public function class_2441()
      {
         super();
      }
      
      public function get canIgnore() : Boolean
      {
         return var_4037;
      }
      
      public function set canIgnore(param1:Boolean) : void
      {
         var_4037 = param1;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function set userId(param1:int) : void
      {
         var_1270 = param1;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function set roomId(param1:int) : void
      {
         var_1951 = param1;
      }
   }
}


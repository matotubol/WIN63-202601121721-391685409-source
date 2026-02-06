package com.sulake.habbo.communication.messages.parser.room.furniture
{
   [SecureSWF(rename="true")]
   public class class_3334
   {
      
      private var var_4834:String;
      
      private var var_839:String;
      
      private var var_735:String;
      
      public function class_3334(param1:String, param2:String, param3:String)
      {
         super();
         var_4834 = param1;
         var_839 = param2;
         var_735 = param3;
      }
      
      public function get playlistId() : String
      {
         return var_4834;
      }
      
      public function get title() : String
      {
         return var_839;
      }
      
      public function get description() : String
      {
         return var_735;
      }
   }
}


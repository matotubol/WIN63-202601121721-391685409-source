package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3828
   {
      
      private var var_2707:int;
      
      private var _name:String;
      
      private var var_2493:int;
      
      private var var_975:String;
      
      private var var_2997:String;
      
      public function class_3828(param1:IMessageDataWrapper)
      {
         super();
         var_2707 = param1.readInteger();
         _name = param1.readString();
         var_2493 = param1.readInteger();
         var_975 = param1.readString();
         var_2997 = param1.readString();
      }
      
      public function dispose() : void
      {
         var_2707 = 0;
         _name = "";
         var_2493 = 0;
         var_975 = "";
         var_2997 = "";
      }
      
      public function get webId() : int
      {
         return var_2707;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get owner() : String
      {
         return var_2997;
      }
   }
}


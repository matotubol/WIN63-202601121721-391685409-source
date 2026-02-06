package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_3828;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_3889;
   
   [SecureSWF(rename="true")]
   public class ConfirmBreedingRequestEventParser implements IMessageParser
   {
      
      private var var_2736:int;
      
      private var _pet1:class_3828;
      
      private var _pet2:class_3828;
      
      private var var_3299:Array;
      
      private var var_5058:int;
      
      public function ConfirmBreedingRequestEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2736 = 0;
         if(_pet1)
         {
            _pet1.dispose();
            _pet1 = null;
         }
         if(_pet2)
         {
            _pet2.dispose();
            _pet2 = null;
         }
         for each(var _loc1_ in var_3299)
         {
            _loc1_.dispose();
         }
         var_3299 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2736 = param1.readInteger();
         _pet1 = new class_3828(param1);
         _pet2 = new class_3828(param1);
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_3299.push(new class_3889(param1));
            _loc2_++;
         }
         var_5058 = param1.readInteger();
         return true;
      }
      
      public function get nestId() : int
      {
         return var_2736;
      }
      
      public function get pet1() : class_3828
      {
         return _pet1;
      }
      
      public function get pet2() : class_3828
      {
         return _pet2;
      }
      
      public function get rarityCategories() : Array
      {
         return var_3299;
      }
      
      public function get resultPetType() : int
      {
         return var_5058;
      }
   }
}


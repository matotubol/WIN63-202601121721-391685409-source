package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2083;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2408;
   
   [SecureSWF(rename="true")]
   public class FriendListUpdateEventParser implements IMessageParser
   {
      
      private var var_5094:Array;
      
      private var var_4699:Array;
      
      private var var_4786:Array;
      
      private var var_4493:Array;
      
      public function FriendListUpdateEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_5094 = [];
         this.var_4699 = [];
         this.var_4786 = [];
         this.var_4493 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            this.var_5094.push(new class_2408(param1));
            _loc5_++;
         }
         var _loc3_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = param1.readInteger();
            if(_loc6_ == -1)
            {
               _loc4_ = param1.readInteger();
               this.var_4699.push(_loc4_);
            }
            else if(_loc6_ == 0)
            {
               this.var_4493.push(new class_2083(param1));
            }
            else if(_loc6_ == 1)
            {
               this.var_4786.push(new class_2083(param1));
            }
            _loc5_++;
         }
         return true;
      }
      
      public function get cats() : Array
      {
         return this.var_5094;
      }
      
      public function get removedFriendIds() : Array
      {
         return this.var_4699;
      }
      
      public function get addedFriends() : Array
      {
         return this.var_4786;
      }
      
      public function get updatedFriends() : Array
      {
         return this.var_4493;
      }
   }
}


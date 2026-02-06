package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class RemoveFriendMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_2066:Array = [];
      
      public function RemoveFriendMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc1_.push(this.var_2066.length);
         _loc2_ = 0;
         while(_loc2_ < this.var_2066.length)
         {
            _loc1_.push(this.var_2066[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addRemovedFriend(param1:int) : void
      {
         this.var_2066.push(param1);
      }
      
      public function dispose() : void
      {
         this.var_2066 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


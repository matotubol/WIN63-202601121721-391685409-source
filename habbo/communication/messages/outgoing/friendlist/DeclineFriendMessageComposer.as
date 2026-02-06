package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class DeclineFriendMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_1695:Array = [];
      
      public function DeclineFriendMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(this.var_1695.length == 0)
         {
            _loc1_.push(true);
            _loc1_.push(0);
         }
         else
         {
            _loc1_.push(false);
            _loc1_.push(this.var_1695.length);
            _loc2_ = 0;
            while(_loc2_ < this.var_1695.length)
            {
               _loc1_.push(this.var_1695[_loc2_]);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function addDeclinedRequest(param1:int) : void
      {
         this.var_1695.push(param1);
      }
      
      public function dispose() : void
      {
         this.var_1695 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


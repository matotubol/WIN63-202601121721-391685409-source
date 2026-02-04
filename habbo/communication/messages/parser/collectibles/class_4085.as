package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4085
   {
      
      private var var_3872:String;
      
      private var _status:int;
      
      private var var_2748:int;
      
      private var var_4367:int;
      
      private var var_5151:Number;
      
      private var var_4250:Number;
      
      private var var_4239:Number;
      
      private var var_4495:Number;
      
      private var var_5083:String;
      
      private var var_2711:String;
      
      private var var_4754:String;
      
      private var var_5132:class_4114;
      
      public function class_4085(param1:IMessageDataWrapper)
      {
         super();
         var_3872 = param1.readString();
         _status = param1.readInteger();
         var_2748 = param1.readInteger();
         var_4367 = param1.readInteger();
         var_5151 = param1.readLong();
         var_4250 = param1.readLong();
         var_4239 = param1.readLong();
         var_4495 = param1.readLong();
         var_5083 = param1.readString();
         var_2711 = param1.readString();
         var_4754 = param1.readString();
         var_5132 = new class_4114(param1);
      }
      
      public function get claimId() : String
      {
         return var_3872;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get claimedAmount() : int
      {
         return var_2748;
      }
      
      public function get claimLimit() : int
      {
         return var_4367;
      }
      
      public function get validFrom() : Number
      {
         return var_5151;
      }
      
      public function get validTo() : Number
      {
         return var_4250;
      }
      
      public function get createdAt() : Number
      {
         return var_4239;
      }
      
      public function get updatedAt() : Number
      {
         return var_4495;
      }
      
      public function get collection() : String
      {
         return var_5083;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get wallet() : String
      {
         return var_4754;
      }
      
      public function get claimItem() : class_4114
      {
         return var_5132;
      }
   }
}


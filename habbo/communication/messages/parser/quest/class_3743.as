package package_139
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3743
   {
      
      private var var_3730:int;
      
      private var var_4430:String;
      
      private var var_4607:String;
      
      private var _amount:int;
      
      public function class_3743(param1:IMessageDataWrapper)
      {
         super();
         var_3730 = param1.readShort();
         var_4430 = param1.readString();
         var_4607 = param1.readString();
         _amount = param1.readInteger();
      }
      
      public function get productItemTypeId() : int
      {
         return var_3730;
      }
      
      public function get rewardTypeId() : String
      {
         return var_4430;
      }
      
      public function get extraParams() : String
      {
         return var_4607;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}


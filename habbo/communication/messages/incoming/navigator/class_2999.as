package package_25
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2999
   {
      
      private var _flatId:int;
      
      private var var_3867:int;
      
      private var var_48:String;
      
      private var _caption:String;
      
      public function class_2999(param1:IMessageDataWrapper)
      {
         super();
         _flatId = param1.readInteger();
         var_3867 = param1.readInteger();
         var_48 = param1.readString();
         _caption = param1.readString();
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get areaId() : int
      {
         return var_3867;
      }
      
      public function get image() : String
      {
         return var_48;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
   }
}


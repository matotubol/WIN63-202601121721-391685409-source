package package_207
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3942 implements IMessageParser
   {
      
      private var var_3171:String = "";
      
      private var var_1951:int = 0;
      
      public function class_3942()
      {
         super();
      }
      
      public function get roomType() : String
      {
         return var_3171;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function flush() : Boolean
      {
         var_3171 = "";
         var_1951 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3171 = param1.readString();
         var_1951 = param1.readInteger();
         return true;
      }
   }
}


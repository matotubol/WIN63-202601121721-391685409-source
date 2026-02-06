package package_203
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredLogEntry
   {
      
      private var var_197:Number;
      
      private var var_3929:int;
      
      private var var_5092:int;
      
      private var var_4757:String;
      
      private var var_2857:Number;
      
      private var var_4777:String;
      
      public function WiredLogEntry(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readLong();
         var_3929 = param1.readByte();
         var_5092 = param1.readByte();
         var_4757 = param1.readString();
         var_2857 = param1.readLong();
         var_4777 = param1.readString();
      }
      
      public function get id() : Number
      {
         return var_197;
      }
      
      public function get logLevel() : int
      {
         return var_3929;
      }
      
      public function get logSource() : int
      {
         return var_5092;
      }
      
      public function get logMessage() : String
      {
         return var_4757;
      }
      
      public function get timestamp() : Number
      {
         return var_2857;
      }
      
      public function get timestampStr() : String
      {
         return var_4777;
      }
   }
}


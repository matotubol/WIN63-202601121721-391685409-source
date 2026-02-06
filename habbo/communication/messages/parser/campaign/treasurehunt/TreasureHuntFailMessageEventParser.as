package package_136
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFailMessageEventParser implements IMessageParser
   {
      
      private var var_2821:String;
      
      private var var_3223:int;
      
      private var var_2786:int;
      
      public function TreasureHuntFailMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2821 = null;
         var_3223 = 0;
         var_2786 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2821 = param1.readString();
         var_3223 = param1.readInteger();
         var_2786 = param1.readInteger();
         return true;
      }
      
      public function get huntId() : String
      {
         return var_2821;
      }
      
      public function get requiredLevel() : int
      {
         return var_3223;
      }
      
      public function get requiredLevelPaying() : int
      {
         return var_2786;
      }
   }
}


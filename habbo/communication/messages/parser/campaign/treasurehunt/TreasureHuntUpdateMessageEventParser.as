package package_136
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_2821:String;
      
      private var var_2921:int;
      
      private var var_2919:int;
      
      private var var_2767:Boolean;
      
      public function TreasureHuntUpdateMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2821 = null;
         var_2921 = 0;
         var_2919 = 0;
         var_2767 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2821 = param1.readString();
         var_2921 = param1.readInteger();
         var_2919 = param1.readInteger();
         var_2767 = param1.readBoolean();
         return true;
      }
      
      public function get huntId() : String
      {
         return var_2821;
      }
      
      public function get stepsCompleted() : int
      {
         return var_2921;
      }
      
      public function get totalSteps() : int
      {
         return var_2919;
      }
      
      public function get isCompleted() : Boolean
      {
         return var_2767;
      }
   }
}


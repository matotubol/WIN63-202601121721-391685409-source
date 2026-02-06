package package_200
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class GetCustomFilterResultMessageEventParser implements IMessageParser
   {
      
      private var var_2629:Array = null;
      
      public function GetCustomFilterResultMessageEventParser()
      {
         super();
         var_2629 = [];
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2629 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2629.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get words() : Array
      {
         return var_2629.slice();
      }
   }
}


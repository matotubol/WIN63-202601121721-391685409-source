package package_111
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetsMessageEventParser implements IMessageParser
   {
      
      private var var_2547:Vector.<class_3106>;
      
      private var var_2673:Vector.<class_3106>;
      
      public function TradeNftAssetsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2547 = null;
         var_2673 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         var_2547 = new Vector.<class_3106>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_2547.push(new class_3106(param1));
            _loc3_++;
         }
         var_2673 = new Vector.<class_3106>();
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_2673.push(new class_3106(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get myItems() : Vector.<class_3106>
      {
         return var_2547;
      }
      
      public function get theirItems() : Vector.<class_3106>
      {
         return var_2673;
      }
   }
}


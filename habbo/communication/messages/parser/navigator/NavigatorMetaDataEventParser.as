package package_15
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_25.class_3644;
   
   [SecureSWF(rename="true")]
   public class NavigatorMetaDataEventParser implements IMessageParser
   {
      
      private var var_3626:Vector.<class_3644>;
      
      public function NavigatorMetaDataEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3626 = new Vector.<class_3644>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_3626.push(new class_3644(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get topLevelContexts() : Vector.<class_3644>
      {
         return var_3626;
      }
   }
}


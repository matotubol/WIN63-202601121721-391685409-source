package package_15
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_25.class_1798;
   
   [SecureSWF(rename="true")]
   public class NavigatorSearchResultBlocksEventParser implements IMessageParser
   {
      
      private var var_2694:class_1798;
      
      public function NavigatorSearchResultBlocksEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2694 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2694 = new class_1798(param1);
         return true;
      }
      
      public function get searchResult() : class_1798
      {
         return var_2694;
      }
   }
}


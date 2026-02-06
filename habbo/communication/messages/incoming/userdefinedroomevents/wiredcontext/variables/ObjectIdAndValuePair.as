package package_189
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ObjectIdAndValuePair
   {
      
      private var var_315:int;
      
      private var _value:int;
      
      public function ObjectIdAndValuePair(param1:IMessageDataWrapper)
      {
         super();
         var_315 = param1.readInteger();
         _value = param1.readInteger();
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get value() : int
      {
         return _value;
      }
   }
}


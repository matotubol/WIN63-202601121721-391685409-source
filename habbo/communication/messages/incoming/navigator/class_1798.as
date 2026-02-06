package package_25
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   [SecureSWF(rename="true")]
   public class class_1798
   {
      
      private var var_3088:String;
      
      private var var_3053:String;
      
      private var var_2464:Vector.<class_1895> = new Vector.<class_1895>(0);
      
      public function class_1798(param1:IMessageDataWrapper, param2:class_1895 = null)
      {
         super();
         if(param2 != null)
         {
            var_3088 = param2.searchCode;
            var_3053 = param2.text;
            var_2464.push(param2);
         }
         else
         {
            var_3088 = param1.readString();
            var_3053 = param1.readString();
            var _loc3_:int = param1.readInteger();
            var _loc4_:int = 0;
         }
      }
      
      public function get searchCodeOriginal() : String
      {
         return var_3088;
      }
      
      public function get filteringData() : String
      {
         return var_3053;
      }
      
      public function get blocks() : Vector.<class_1895>
      {
         return var_2464;
      }
      
      public function findGuestRoom(param1:int) : class_1945
      {
         var _loc3_:class_1945 = null;
         for each(var _loc2_ in var_2464)
         {
            _loc3_ = _loc2_.findGuestRoom(param1);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}


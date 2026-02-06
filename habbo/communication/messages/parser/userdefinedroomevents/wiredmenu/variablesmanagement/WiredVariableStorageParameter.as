package package_201
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredVariableStorageParameter
   {
      
      private var var_3951:String;
      
      private var _value:int;
      
      private var _creationTime:Number;
      
      private var var_4680:String;
      
      private var _lastUpdateTime:Number;
      
      private var var_4350:String;
      
      public function WiredVariableStorageParameter(param1:IMessageDataWrapper, param2:Boolean = false)
      {
         super();
         if(param2)
         {
            var_3951 = param1.readString();
         }
         _value = param1.readInteger();
         _creationTime = param1.readLong();
         var_4680 = param1.readString();
         _lastUpdateTime = param1.readLong();
         var_4350 = param1.readString();
      }
      
      public function get variableId() : String
      {
         return var_3951;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get creationTime() : Number
      {
         return _creationTime;
      }
      
      public function get creationTimeStr() : String
      {
         return var_4680;
      }
      
      public function get lastUpdateTime() : Number
      {
         return _lastUpdateTime;
      }
      
      public function get lastUpdateTimeStr() : String
      {
         return var_4350;
      }
   }
}


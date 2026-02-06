package package_189
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.class_55;
   
   public class WiredVariable
   {
      
      public static var var_636:String = "n";
      
      private var var_3951:String;
      
      private var var_1041:int;
      
      private var _variableName:String;
      
      private var var_2009:int;
      
      private var var_1252:int;
      
      private var var_4454:Boolean;
      
      private var var_4408:Boolean;
      
      private var var_4663:Boolean;
      
      private var var_4046:Boolean;
      
      private var var_4652:Boolean;
      
      private var var_3832:Boolean;
      
      private var var_4147:Boolean;
      
      private var var_4466:Boolean;
      
      private var var_2900:class_55;
      
      public function WiredVariable(param1:IMessageDataWrapper)
      {
         super();
         var_3951 = param1.readString();
         var_1041 = param1.readInteger();
         _variableName = param1.readString();
         var_2009 = param1.readInteger();
         var_1252 = param1.readInteger();
         var_4454 = param1.readBoolean();
         var_4408 = param1.readBoolean();
         var_4663 = param1.readBoolean();
         var_4046 = param1.readBoolean();
         var_4652 = param1.readBoolean();
         var_3832 = param1.readBoolean();
         var_4147 = param1.readBoolean();
         var_4466 = param1.readBoolean();
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            var_2900 = new class_55();
            var _loc3_:int = param1.readInteger();
            var _loc4_:int = 0;
         }
      }
      
      public function get variableId() : String
      {
         return var_3951;
      }
      
      public function get variableType() : int
      {
         return var_1041;
      }
      
      public function get variableName() : String
      {
         return _variableName;
      }
      
      public function get availabilityType() : int
      {
         return var_2009;
      }
      
      public function get variableTarget() : int
      {
         return var_1252;
      }
      
      public function get alwaysAvailable() : Boolean
      {
         return var_4454;
      }
      
      public function get canCreateAndDelete() : Boolean
      {
         return var_4408;
      }
      
      public function get hasValue() : Boolean
      {
         return var_4663;
      }
      
      public function get canWriteValue() : Boolean
      {
         return var_4046;
      }
      
      public function get canInterceptChanges() : Boolean
      {
         return var_4652;
      }
      
      public function get isInvisible() : Boolean
      {
         return var_3832;
      }
      
      public function get canReadCreationTime() : Boolean
      {
         return var_4147;
      }
      
      public function get canReadLastUpdateTime() : Boolean
      {
         return var_4466;
      }
      
      public function get hasTextConnector() : Boolean
      {
         return var_2900 != null;
      }
      
      public function get textConnector() : class_55
      {
         return var_2900;
      }
      
      public function get isStored() : Boolean
      {
         return var_2009 < 100;
      }
      
      public function get isPersisted() : Boolean
      {
         return var_2009 == class_3904.var_3714 || var_2009 == class_3904.var_3636 || var_2009 == class_3904.var_5212;
      }
   }
}


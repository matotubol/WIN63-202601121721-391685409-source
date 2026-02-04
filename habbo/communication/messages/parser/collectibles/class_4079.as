package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4079
   {
      
      private var var_4497:int;
      
      private var _startTime:int;
      
      private var _endTime:int;
      
      private var var_5029:Boolean;
      
      private var var_3071:int;
      
      private var var_4088:Boolean;
      
      private var var_757:String;
      
      public function class_4079(param1:IMessageDataWrapper)
      {
         super();
         var_4497 = param1.readInteger();
         _startTime = param1.readInteger();
         _endTime = param1.readInteger();
         var_5029 = param1.readBoolean();
         var_3071 = param1.readInteger();
         var_4088 = param1.readBoolean();
         var _loc2_:int = param1.readShort();
         switch(_loc2_)
         {
            case 0:
               var_757 = "s";
               break;
            case 1:
               var_757 = "i";
               break;
            case 2:
               var_757 = "cl";
               break;
            default:
               var_757 = "s";
         }
      }
      
      public function get itemTypeId() : int
      {
         return var_4497;
      }
      
      public function get startTime() : int
      {
         return _startTime;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
      
      public function get regionLocked() : Boolean
      {
         return var_5029;
      }
      
      public function get price() : int
      {
         return var_3071;
      }
      
      public function get limitedEdition() : Boolean
      {
         return var_4088;
      }
      
      public function get itemType() : String
      {
         return var_757;
      }
   }
}


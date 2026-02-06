package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OpenPetPackageResultMessageEventParser implements IMessageParser
   {
      
      private var var_315:int = 0;
      
      private var _nameValidationStatus:int = 0;
      
      private var _nameValidationInfo:String = null;
      
      public function OpenPetPackageResultMessageEventParser()
      {
         super();
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get nameValidationStatus() : int
      {
         return _nameValidationStatus;
      }
      
      public function get nameValidationInfo() : String
      {
         return _nameValidationInfo;
      }
      
      public function flush() : Boolean
      {
         var_315 = 0;
         _nameValidationStatus = 0;
         _nameValidationInfo = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_315 = param1.readInteger();
         _nameValidationStatus = param1.readInteger();
         _nameValidationInfo = param1.readString();
         return true;
      }
   }
}


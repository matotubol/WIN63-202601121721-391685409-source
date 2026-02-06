package com.sulake.habbo.communication.messages.incoming.landingview
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4098
   {
      
      public static const const_712:int = 0;
      
      public static const const_1153:int = 1;
      
      public static const const_811:int = 2;
      
      private var var_197:int;
      
      private var var_839:String;
      
      private var var_4481:String;
      
      private var var_3935:String;
      
      private var var_4779:int;
      
      private var var_4341:String;
      
      private var var_319:String;
      
      public function class_4098(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readInteger();
         var_839 = param1.readString();
         var_4481 = param1.readString();
         var_3935 = param1.readString();
         var_4779 = param1.readInteger();
         var_4341 = param1.readString();
         var_319 = param1.readString();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get title() : String
      {
         return var_839;
      }
      
      public function get bodyText() : String
      {
         return var_4481;
      }
      
      public function get buttonText() : String
      {
         return var_3935;
      }
      
      public function get linkType() : int
      {
         return var_4779;
      }
      
      public function get linkContent() : String
      {
         return var_4341;
      }
      
      public function get imageUrl() : String
      {
         return var_319;
      }
   }
}


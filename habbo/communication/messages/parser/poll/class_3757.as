package com.sulake.habbo.communication.messages.parser.poll
{
   [SecureSWF(rename="true")]
   public class class_3757
   {
      
      public static const const_472:int = 0;
      
      public static const const_1045:int = 1;
      
      public static const const_467:int = 2;
      
      public static const const_1060:int = 3;
      
      private var var_2943:int;
      
      private var var_4108:int;
      
      private var var_4967:int;
      
      private var var_5099:int;
      
      private var var_4109:String;
      
      private var var_4151:int;
      
      private var var_4552:int;
      
      private var _children:Vector.<class_3757>;
      
      private var var_2729:Vector.<class_3851>;
      
      public function class_3757()
      {
         super();
         _children = new Vector.<class_3757>();
         var_2729 = new Vector.<class_3851>();
      }
      
      public function get questionId() : int
      {
         return var_2943;
      }
      
      public function set questionId(param1:int) : void
      {
         var_2943 = param1;
      }
      
      public function get questionType() : int
      {
         return var_4108;
      }
      
      public function set questionType(param1:int) : void
      {
         var_4108 = param1;
      }
      
      public function get sortOrder() : int
      {
         return var_4967;
      }
      
      public function set sortOrder(param1:int) : void
      {
         var_4967 = param1;
      }
      
      public function get questionText() : String
      {
         return var_4109;
      }
      
      public function set questionText(param1:String) : void
      {
         var_4109 = param1;
      }
      
      public function get questionCategory() : int
      {
         return var_5099;
      }
      
      public function set questionCategory(param1:int) : void
      {
         var_5099 = param1;
      }
      
      public function get questionAnswerType() : int
      {
         return var_4151;
      }
      
      public function set questionAnswerType(param1:int) : void
      {
         var_4151 = param1;
      }
      
      public function get questionAnswerCount() : int
      {
         return var_4552;
      }
      
      public function set questionAnswerCount(param1:int) : void
      {
         var_4552 = param1;
      }
      
      public function get children() : Vector.<class_3757>
      {
         return _children;
      }
      
      public function set children(param1:Vector.<class_3757>) : void
      {
         _children = param1;
      }
      
      public function get questionChoices() : Vector.<class_3851>
      {
         return var_2729;
      }
      
      public function set questionChoices(param1:Vector.<class_3851>) : void
      {
         var_2729 = param1;
      }
   }
}


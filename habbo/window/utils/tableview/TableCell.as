package com.sulake.habbo.window.utils.tableview
{
   public class TableCell
   {
      
      public static var var_101:int = 0;
      
      public static var var_2973:int = 1;
      
      private var var_230:int;
      
      private var var_160:Object;
      
      private var var_3843:Boolean;
      
      private var var_4994:Boolean;
      
      private var var_3885:String;
      
      private var _linkClickCallback:Function;
      
      private var _highlightOnChange:Boolean;
      
      private var var_4101:String;
      
      private var _textColor:int;
      
      private var var_4213:String;
      
      private var _extraBtnCallback:Function;
      
      public function TableCell(param1:int, param2:Object, param3:Boolean = false, param4:Boolean = false, param5:String = null, param6:Function = null, param7:Boolean = false, param8:String = null, param9:uint = 0)
      {
         super();
         var_230 = param1;
         var_160 = param2;
         var_4994 = param3;
         var_3843 = param4;
         _linkClickCallback = param6;
         if(param5 == null && (param3 || param4))
         {
            param5 = param2 as String;
         }
         var_3885 = param5;
         _highlightOnChange = param7;
         var_4101 = param8;
         _textColor = param9;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get isEditable() : Boolean
      {
         return var_4994;
      }
      
      public function get contents() : Object
      {
         return var_160;
      }
      
      public function get isInspectable() : Boolean
      {
         return var_3843;
      }
      
      public function get textFieldValue() : String
      {
         return var_3885;
      }
      
      public function get linkClickCallback() : Function
      {
         return _linkClickCallback;
      }
      
      public function get highlightOnChange() : Boolean
      {
         return _highlightOnChange;
      }
      
      public function get tooltipText() : String
      {
         return var_4101;
      }
      
      public function get textColor() : int
      {
         return _textColor;
      }
      
      public function setExtraBtn(param1:String, param2:Function) : *
      {
         var_4213 = param1;
         _extraBtnCallback = param2;
      }
      
      public function get extraBtn() : String
      {
         return var_4213;
      }
      
      public function get extraBtnCallback() : Function
      {
         return _extraBtnCallback;
      }
   }
}


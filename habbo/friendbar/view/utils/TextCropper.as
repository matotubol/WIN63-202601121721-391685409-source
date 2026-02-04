package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.ITextWindow;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextCropper implements class_13
   {
      
      private var _disposed:Boolean = false;
      
      private var var_76:TextField;
      
      private var var_2154:TextFormat;
      
      private var var_5332:String = "...";
      
      private var var_5295:int = 20;
      
      public function TextCropper()
      {
         super();
         var_76 = new TextField();
         var_76.autoSize = "left";
         var_76.antiAliasType = "advanced";
         var_76.gridFitType = "pixel";
         var_2154 = var_76.defaultTextFormat;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_76 = null;
            _disposed = true;
         }
      }
      
      public function crop(param1:ITextWindow) : void
      {
         var_2154.font = param1.fontFace;
         var_2154.size = param1.fontSize;
         var_2154.bold = param1.bold;
         var_2154.italic = param1.italic;
         var_76.setTextFormat(var_2154);
         var_76.text = param1.getLineText(0);
         var _loc3_:int = var_76.textWidth;
         if(_loc3_ > param1.width)
         {
            var _loc2_:int = var_76.getCharIndexAtPoint(param1.width - var_5295,var_76.textHeight / 2);
            param1.text = param1.text.slice(0,0) + var_5332;
         }
      }
   }
}


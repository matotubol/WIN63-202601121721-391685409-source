package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1901;
   
   public interface IIlluminaChatBubbleWidget extends class_1901
   {
      
      function get flipped() : Boolean;
      
      function set flipped(param1:Boolean) : void;
      
      function get userName() : String;
      
      function set userName(param1:String) : void;
      
      function get userId() : int;
      
      function set userId(param1:int) : void;
      
      function get figure() : String;
      
      function set figure(param1:String) : void;
      
      function get numMessages() : int;
      
      function getMessage(param1:int) : String;
      
      function setMessage(param1:int, param2:String) : void;
      
      function appendMessage(param1:String, param2:Boolean = false, param3:int = 0) : void;
      
      function get timeStamp() : Number;
      
      function set timeStamp(param1:Number) : void;
      
      function set friendOnlineStatus(param1:Boolean) : void;
      
      function setAwaitingConfirmationId(param1:int, param2:int) : void;
      
      function clearAwaitingConfirmationId(param1:int) : void;
      
      function getAwaitingConfirmationId(param1:int) : int;
   }
}


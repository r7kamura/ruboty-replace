require "ruboty"

module Ruboty
  module Handlers
    class Replace < Base
      on(
        //,
        all: true,
        description: "Replace message with registered patterns",
        hidden: true,
        name: :replace,
      )

      on(
        %r<replace (?<pattern>.+?) with (?<template>.+)>m,
        description: "Register pattern to replace",
        name: :register,
      )

      def register(message)
        puts "TODO"
      end

      def replace(message)
        puts "TODO"
      end
    end
  end
end

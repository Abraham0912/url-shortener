require "rails_helper"

RSpec.describe Link do
    it "Deberia existir una clase de nombre Link" do
        
    end

    it "Deberia validar que existe un url campo" do
        value = Link.new(url: nil)
        expect(value).to_not be_valid
    end

    it "Deberia validar que code campo es unico" do
        Link.create(code: "123456")
        value = Link.new(url: nil)
        expect(value).to_not be_valid
    end

    it "Deberia validar que code campo es tamaño 6" do
        # your code
    end

    it "Deberia validar que url campo tiene un formato html || htmls" do
        # your code
    end
end
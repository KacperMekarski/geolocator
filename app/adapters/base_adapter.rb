class BaseAdapter
  Result = Struct.new(:success, :value, :error) do
    def success?
      success
    end

    def failure?
      !success
    end
  end
end

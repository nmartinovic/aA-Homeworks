class Employee

    attr_reader :name, :title, :salary, :boss
    def initialize(name, title, salary, boss)
        @name, @title, @salary, @boss = name, title, salary, boss
    end

    def bonus(multiplier)
        bonus = @salary * multiplier
    end

end


class Manager < Employee

    def initialize(name, title, salary, boss,employees)
        super(name, title, salary, boss)
        @employees = employees
    end

    def bonus(multiplier)
        base = 0
        @employees.each do |employee|
            base += employee.salary 
        end
        base * multiplier
    end

end